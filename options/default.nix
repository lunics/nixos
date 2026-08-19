{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      terminal = mkOption {
        type    = types.str;
        default = "ghostty";
      };

      openai_api_key = mkOption {
        type    = types.str;
        default = "";
      };

      github_token = mkOption {
        type    = types.str;
        default = "";
      };

      splitkb   = mkEnableOption "";

      devbox    = mkEnableOption "";

      keyring = mkOption {
        type    = types.str;
        default = "";
      };

      external_vpn = mkOption {
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
