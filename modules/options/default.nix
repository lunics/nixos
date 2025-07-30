{ config, lib, ... }:{
  imports = [
    ./users.nix
    # ./sudo.nix
    ./zramSwap.nix
    ./virtualisation.nix
    ./gaming.nix
  ];

  options = {
    _window_manager = lib.mkEnableOption "";

    _login_manager = lib.mkEnableOption "";

    _audio = lib.mkEnableOption "";

    _crypttab.text = lib.mkOption {
      type    = lib.types.str;
      default = "";
    };

    _.hostName = lib.mkOption {
      type    = lib.types.str;
      default = "nixos";
    };
  };
}
