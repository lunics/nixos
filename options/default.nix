{
  flake.aspects.options.nixos = { lib, ... }: with lib; {
    options._ = {
      editor = mkOption {
        type    = types.str;
        default = "nvim";
      };

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

      flake_dir = mkOption {
        type    = types.str;
        default = "";
      };

      splitkb   = mkEnableOption "";

      ansible   = mkEnableOption "";

      terraform = mkEnableOption "";

      winboat   = mkEnableOption "";

      devbox    = mkEnableOption "";

      kube      = mkEnableOption "";

      keyring = mkOption {
        type    = types.str;
        default = "";
      };

      external_vpn = mkOption {
        type    = types.str;
        default = "";
      };

      instaloader_login = lib.mkOption {
        type    = types.nullOr types.path;
        default = null;
      };

      pass_manager = mkOption {
        type    = types.str;
        default = "gopass";
      };

      passage = mkEnableOption "";

      age_identities = lib.mkOption {
        type    = types.nullOr types.path;
        default = null;
      };

      pomodoro = mkEnableOption "";

      alarm-clock = mkEnableOption "";
    };
  };
}
