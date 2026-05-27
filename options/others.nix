{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
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

      wsl = mkEnableOption "";

      headless = mkEnableOption "";
    };
  };
}
