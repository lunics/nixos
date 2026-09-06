{
  flake.aspects.persistent.nixos = { config, lib, ... }:{
    _.persistent-system.dirs = [
      "/persistent"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/snapshots"
    ];

    _.persistent-system.files = [
      { file = "/etc/machine-id"; inInitrd = true; }
    ];
  };
}
