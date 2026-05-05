{
  flake.modules.generic.options = { lib, ... }: with lib; {
    options._ = {
      flake_dir = mkOption {
        type    = types.str;
        default = "";
      };

      boot_loader = mkOption {
        type    = types.str;
        default = "systemd-boot";     # systemd-boot, grub
      };

      boot_splash = mkOption {
        type    = types.str;
        default = "";                 # plymouth
      };

      login_manager = mkEnableOption "";

      audio  = mkEnableOption "";
      musnix = mkEnableOption "";

      crypttab.text = mkOption {
        type    = types.str;
        default = "";
      };

      graphic = mkEnableOption "";

      laptop_lid = mkOption {
        type    = types.str;
        default = "suspend";
      };

      nix.trusted-users = mkOption {
        type    = types.listOf types.str;
        default = [];
      };

      github_token = mkOption {
        type    = types.str;
        default = "";
      };

      wsl = mkEnableOption "";

      headless = mkEnableOption "";
    };
  };
}
