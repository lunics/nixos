{
  flake.aspects.persistent.nixos = { config, lib, ... }:{
    _.persistent-system.dirs = [
      "/persistent"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd"    # machine credentials, random seed, persistent timers, backlight, rfkill
      "/snapshots"
    ];

    _.persistent-system.files = [
      { file = "/etc/machine-id"; inInitrd = true; }
    ];
  };
}
