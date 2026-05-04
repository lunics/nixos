{
  flake.modules.generic.myoptions = { lib, ... }: with lib; {
    options._ = {
      yubikey = mkEnableOption "";

      u2f_keys = mkOption {
        type    = types.nullOr types.path;
        default = null;
      };
    };
  };
}
