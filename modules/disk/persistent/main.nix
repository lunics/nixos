{
  flake.aspects.persistent.nixos = { config, ... }:{
    # merged into the btrfs layout by the disk aspect
    _.disk.subvolumes."/persistent".mountpoint = config._.persistent-system.dest;

    # /var/log and /.snapshots are btrfs subvolumes of their own, they must not be bind mounted over
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
