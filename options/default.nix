{ config, lib, ... }:{
  imports = [
    ./users.nix
    # ./sudo.nix
    ./zramSwap.nix
    ./virtualisation.nix
    ./gaming.nix
    ./window_manager.nix
  ];

  options._ = {
    login_manager = lib.mkEnableOption "";

    audio = lib.mkEnableOption "";

    crypttab.text = lib.mkOption {
      type    = lib.types.str;
      default = "";
    };

    hostName = lib.mkOption {
      type    = lib.types.str;
      default = "nixos";
    };

    graphic = lib.mkEnableOption "";

    dns_server = lib.mkEnableOption "";
  };
}
