{
  flake.aspects.persistent.nixos = { config, lib, ... }:{
    _.persistent-system.dirs = [
      "/persistent"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/snapshots"
    ];
  };
}
