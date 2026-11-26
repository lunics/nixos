{
  flake.aspects.btrbk.nixos = { config, lib, pkgs, ... }:
  let
    # snapshot name -> subvolume relative to the top level, eg. lunics -> nix/persistent/home/lunics
    subvolumes = lib.listToAttrs (map (path: {
      name  = baseNameOf path;
      value = lib.removePrefix "/" path;
    }) config._.persistent-subvolumes);
    target = if config._.btrbk.target != null then config._.btrbk.target else "";
  in {
    environment.systemPackages = [
      (pkgs.writers.writeNuBin "persistent-restore" {
        makeWrapperArgs = [
          "--prefix" "PATH" ":" "${lib.makeBinPath [ pkgs.btrfs-progs pkgs.systemd pkgs.util-linux pkgs.coreutils pkgs.getent ]}"
        ];
      } ''
        const local    = "/mnt/snapshots/btrbk"     # btrbk snapshot_dir
        const requests = "/mnt/snapshots/restore"   # read by the persistent-restore initrd service

        # leaves time to read each step before the next one, the last ones before the reboot
        def say [message: string] {
          print $message
          sleep 2sec
        }

        # sorted names of the snapshots of one subvolume, oldest first
        def snapshots [dir: string, name: string] {
          if not ($dir | path exists) { return [] }
          ls $dir | where type == dir | get name | path basename
            | where {|snap| $snap starts-with $"($name)." } | sort
        }

        # sends the snapshots missing in `to`, incremental from the closest older one both sides share
        def sync [from: string, to: string, name: string] {
          for snap in (snapshots $from $name) {
            let present = (snapshots $to $name)
            if $snap in $present { continue }

            let parents = ($present | where {|p| $p < $snap and ($"($from)/($p)" | path exists) })
            say $"($from)/($snap) -> ($to)"
            if ($parents | is-empty) {
              btrfs send $"($from)/($snap)" | btrfs receive $to
            } else {
              btrfs send -p $"($from)/($parents | last)" $"($from)/($snap)" | btrfs receive $to
            }
          }
        }

        # syncs the snapshots of one subvolume with the backup, then restores one of them at the next boot
        def main [
          name: string        # system or a user, the snapshot basename
          snapshot?: string   # defaults to the latest one
        ] {
          let subvolumes = ('${builtins.toJSON subvolumes}' | from json)
          let target     = "${target}"

          if not (is-admin) { error make --unspanned { msg: "run it as root" } }
          if $name not-in ($subvolumes | columns) {
            error make --unspanned { msg: $"unknown subvolume '($name)': expected one of ($subvolumes | columns | str join ', ')" }
          }

          if ($target | is-empty) {
            say "_.btrbk.target is not set, only the local snapshots are used"
          } else if not ($target | path exists) {
            error make --unspanned { msg: $"backup target ($target) not found, is the disk mounted?" }
          } else {
            sync $target $local $name    # snapshots already pruned locally
            sync $local $target $name    # snapshots not backed up yet
          }

          let available = (snapshots $local $name)
          if ($available | is-empty) { error make --unspanned { msg: $"no snapshot of ($name) in ($local)" } }

          let chosen = if $snapshot == null { $available | last } else { $snapshot }
          if $chosen not-in $available { error make --unspanned { msg: $"snapshot ($chosen) not found in ($local)" } }

          mkdir $requests
          $"($subvolumes | get $name) ($chosen)" | save -f $"($requests)/($name)"
          say $"($subvolumes | get $name) will be replaced by ($chosen) at the next boot"

          if (input "reboot now? [y/N] " | str lowercase) != "y" { return }

          # the backup disk is unmounted cleanly, the system disk resolves to the same uuid as /nix
          if not ($target | is-empty) and ($target | path exists) {
            if (findmnt -no UUID -T $target) != (findmnt -no UUID -T /nix) {
              let mount = (findmnt -no TARGET -T $target | str trim)
              ^sync
              ^umount $mount
              say $"($mount) unmounted"
            }
          }

          # like the reboot alias, the user saves its session first, a failure aborts the reboot
          let user = ($env.SUDO_USER? | default "")
          if not ($user | is-empty) {
            let uid  = (id -u $user | str trim)
            let home = (getent passwd $user | str trim | split row ":" | get 5)
            # a login bash misses the home-manager profiles, integrated or standalone
            let found = ([
              $"/etc/profiles/per-user/($user)/bin/save_env"
              $"($home)/.local/state/nix/profiles/home-manager/home-path/bin/save_env"
              $"($home)/.nix-profile/bin/save_env"
            ] | where {|path| $path | path exists })

            if ($found | is-empty) {
              say $"save_env not found for ($user), its session is not saved"
            } else {
              runuser -l $user -c $"XDG_RUNTIME_DIR=/run/user/($uid) ($found | first)"
              sleep 2sec                 # save_env prints its own messages
            }
          }

          systemctl reboot
        }
      '')
    ];
  };
}
