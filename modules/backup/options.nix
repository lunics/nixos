{
  flake.aspects.options.vars = { lib, ... }: with lib; {
    options._ = {
      btrbk = {
        target = mkOption {   # local btrfs directory receiving the backups, null: snapshots only
          type    = types.nullOr types.str;
          default = null;
        };
      };
    };
  };
}
