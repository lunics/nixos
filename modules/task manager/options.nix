{
  flake.aspects.options.vars = { lib, ... }: with lib; {
    options._.current-taskw-dest = mkOption {
      type    = types.nullOr types.str;
      default = null;
    };
  };
}
