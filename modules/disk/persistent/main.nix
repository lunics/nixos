{
  flake.aspects.persistent.nixos = { config, ... }:{
    # nested in the /nix subvolume, reachable without a mount since /nix is mounted in the initrd
    _.disk.subvolumes.${config._.persistent-system.dest} = {};

    # /var/log and /mnt/snapshots are btrfs subvolumes of their own, they must not be bind mounted over
    _.persistent-system = {
      dirs = [
        "/var/lib/nixos"      # uid and gid maps, what keeps the users stable across a wipe
        "/var/lib/systemd"    # machine credentials, random seed, persistent timers, backlight, rfkill
        # "/var/tmp"          # temporary files meant to survive a reboot, wiped with the root subvolume
      ];
      files = [
        { file = "/etc/machine-id"; inInitrd = true; }
      ];
    };
  };
}
