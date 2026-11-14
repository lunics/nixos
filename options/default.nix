{
  flake.aspects.options.vars = { lib, ... }: with lib; {
    options._ = {
      user = mkOption {
        type    = types.str;
        default = "user-nix";
      };

      user_id = mkOption {
        type    = types.int;
        default = 1000;
      };

      openai_api_key = mkOption {
        type    = types.str;
        default = "";
      };

      splitkb   = mkEnableOption "";

      devbox    = mkEnableOption "";

      keyring = mkOption {
        type    = types.str;
        default = "";
      };

      alarm-clock = mkEnableOption "";

      gpu-nvidia-uuid = mkOption {
        type    = types.str;
        default = "";
      };

      udiskie-devices = mkOption {
        type    = types.listOf (types.attrsOf types.str);
        default = [];
      };

      gps-coordinates = mkOption {
        type    = types.str;
        default = "";
      };

      cpu-max-temp = mkOption {
        type    = types.nullOr (types.ints.between 0 100);
        default = null;
      };
    };
  };
}
