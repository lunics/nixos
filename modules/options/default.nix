{ config, lib, ... }:{
  imports = [
    ./virtualisation.nix
    ./zramSwap.nix
    ./gaming.nix
  ];

  options = {
    _window_manager = lib.mkEnableOption "";

    _login_manager = lib.mkEnableOption "";

    _audio = lib.mkEnableOption "";

    _crypttab.text = lib.mkOption {
      default = "";
      type    = lib.types.str;
    };
  };
}
