{
  flake.aspects.options.nixos = { lib, ... }: with lib; {
    options._.wifi = mkOption {
      type    = types.attrsOf types.str;
      default = {};
    };
  };
}
