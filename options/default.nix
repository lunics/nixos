{ config, lib, ... }: with lib; {
  imports = [
    ./users.nix
    # ./sudo.nix
    ./zramSwap.nix
    ./virtualisation.nix
    ./gaming.nix
    ./window_manager.nix
    ./wifi.nix
    ./udev.nix
  ];

  options._ = {
    hostName = mkOption {
      type    = types.str;
      default = "nixos";
    };

    login_manager = mkEnableOption "";

    audio = mkEnableOption "";

    crypttab.text = mkOption {
      type    = types.str;
      default = "";
    };

    graphic = mkEnableOption "";

    dns_server = mkEnableOption "";

    laptop_lid = mkOption {
      type    = types.str;
      default = "suspend";
    };

    nix.trusted-users = mkOption {
      type    = types.listOf types.str;
      default = [];
    };
  };
}
