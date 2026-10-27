{
  flake.aspects.persistent.nixos = { config, lib, ... }:{
    # /var/log and /snapshots are btrfs subvolumes of their own, they must not be bind mounted over
    _.persistent-system.dirs = [
      "/var/lib/nixos"      # uid and gid maps, what keeps the users stable across a wipe
      "/var/lib/systemd"    # machine credentials, random seed, persistent timers, backlight, rfkill
    ];

    _.persistent-system.files = [
      { file = "/etc/machine-id"; inInitrd = true; }
    ];
  };
}
