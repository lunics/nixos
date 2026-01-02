{ lib, ... }: with lib; {
  imports = [
    ./disk.nix
    ./users.nix
    ./sudo.nix
    ./zramSwap.nix
    ./virtualisation.nix
    ./gaming.nix
    ./window_manager.nix
    ./wifi.nix
    ./udev.nix
    # ./impermanence.nix
  ];

  options._ = {
    hostName = mkOption {
      type    = types.str;
      default = "nixos";
    };

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

    audio = mkEnableOption "";
    musnix = mkEnableOption "";

    crypttab.text = mkOption {
      type    = types.str;
      default = "";
    };

    graphic = mkEnableOption "";

    dns = {
      bind9 = mkEnableOption "";
      nsd   = mkEnableOption "";
    };

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

    yubikey = mkEnableOption "";
  };
}
