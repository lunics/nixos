{
  flake.aspects.btrbk.nixos = { config, lib, pkgs, ... }:
  let
    subvolumes = map (lib.removePrefix "/") config._.persistent-subvolumes;   # relative to the "/" volume
    target     = config._.btrbk.target;

    # an unmounted disk resolves to / or /nix: back up only to another mounted btrfs, else keep the local snapshots
    run-or-snapshot = pkgs.writeShellApplication {
      name          = "btrbk-persistent";
      runtimeInputs = [ pkgs.btrbk pkgs.coreutils pkgs.util-linux ];
      text = ''
        target=${lib.escapeShellArg (toString target)}
        existing=$target
        while [ ! -e "$existing" ]; do existing=$(dirname "$existing"); done

        if [ "$(findmnt -no FSTYPE -T "$existing")" = btrfs ] \
           && [ "$(findmnt -no UUID -T "$existing")" != "$(findmnt -no UUID -T /nix)" ]; then
          mkdir -p "$target"
          exec btrbk -v -c /etc/btrbk/persistent.conf run
        fi

        echo "backup disk not mounted, $target resolves to $(findmnt -no TARGET -T "$existing"): local snapshots only" >&2
        exec btrbk -v -c /etc/btrbk/persistent.conf snapshot --preserve-snapshots   # keeps the parent of the next incremental send
      '';
    };
  in {
    services.btrbk = {
      # sshAccess = { # SSH keys that should be able to make or push snapshots on this system remotely
      #   key
      #   roles
      # }; 
      # onCalendar        = "daily";
      # niceness          = 10;               # niceness for local instances
      # ioSchedulingClass = "best-effort";    # best-effort, idle, realtime
      # instances = {
      #   "btrbk" = {                         # default instance name
      #     settings = {
      #       stream_compress       = "no";   # gzip, pigz, bzip2, pbzip2, bzip3, xz, lzo, lz4, zstd, no
      #       snapshot_preserve     = "14d";
      #       snapshot_preserve_min = "2d";
      #       volume = {
      #         "/mnt/btr_pool" = {
      #           subvolume = {
      #             home = {
      #               snapshot_create = "always";
      #             };
      #             rootfs = { };
      #           };
      #           target = "/mnt/btr_backup/mylaptop";
      #         };
      #       };
      #     };
      #     snapshotOnly = false;             # to skip backup creation and deletion steps
      #                                       # when you want to manually backup to an external drive
      #   };
      # };
      instances."persistent" = {              # service btrbk-persistent, /home is ephemeral and not worth a backup
        onCalendar   = null;                  # no timer, run with: systemctl start btrbk-persistent
        snapshotOnly = config._.btrbk.target == null;
        settings = {
          backend               = "btrfs-progs";  # btrfs called directly, the sudo wrapper is wheel-only
          snapshot_preserve_min = "2d";
          snapshot_preserve     = "14d";
          volume."/" = {
            snapshot_dir = "mnt/snapshots/btrbk";   # relative to the volume, same btrfs filesystem as /nix
            subvolume    = lib.genAttrs subvolumes (name: {});   # system + one per user, snapshots named after the basename
          } // lib.optionalAttrs (config._.btrbk.target != null) {
            target       = config._.btrbk.target;              # every backup kept, btrbk's target_preserve_min defaults to all
          };
        };
      };
      extraPackages = [];
    };
    systemd.services.btrbk-persistent.description = lib.mkForce "Snapshot the persistent subvolumes and send them to the backup disk";
    systemd.services.btrbk-persistent.serviceConfig = {   # root is required by the btrfs-progs backend
      User  = lib.mkForce "root";
      Group = lib.mkForce "root";
    } // lib.optionalAttrs (target != null) {
      ExecStart = lib.mkForce (lib.getExe run-or-snapshot);
    };
    systemd.tmpfiles.rules = ["d /mnt/snapshots/btrbk 0755 root root -"];  # snapshot_dir must exist before the first run
  };
}
