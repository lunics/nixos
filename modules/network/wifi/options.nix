{
  flake.aspects.options.vars = { lib, ... }: with lib; {
    options._.wifi = mkOption {
      type    = types.attrsOf types.str;
      default = {};
    };
  };
}
