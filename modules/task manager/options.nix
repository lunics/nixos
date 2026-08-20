{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._.current-taskw-dest = mkOption {
      type    = types.nullOr types.str;
      default = null;
    };
  };
}
