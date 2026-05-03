{ lib, ... }: {
  options._.wifi = lib.mkOption {
    type    = lib.types.attrsOf lib.types.str;
    default = {};
  };
}
