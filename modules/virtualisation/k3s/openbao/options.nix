{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      openbao.snapshot = {
        enable = mkOption {
          type    = types.bool;
          default = true;
        };
        dir = mkOption {
          type    = types.str;
          default = "/var/lib/openbao-snapshots";   # same disk as the raft storage, point it elsewhere for a real backup
        };
        keep-days = mkOption {
          type    = types.ints.positive;
          default = 14;
        };
      };
    };
  };
}
