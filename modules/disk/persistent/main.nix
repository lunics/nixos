{
  flake.aspects.persistent.nixos = { config, lib, ... }:{
    _.persistent.dirs = lib.mkIf config._.impermanence [
      "/persistent"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/snapshots"
    ];
  };
}
