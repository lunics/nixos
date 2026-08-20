{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._.current-task-path = mkOption {
      type    = types.nullOr types.str;
      default = null;
    };
  };
}
