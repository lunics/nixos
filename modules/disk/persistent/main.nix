{
  flake.aspects.persistent.nixos = { config, lib, ... }:{
    _.persistent-system.dirs = lib.mkIf config._.persistent [
      "/persistent"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/snapshots"
    ];
  };
}
