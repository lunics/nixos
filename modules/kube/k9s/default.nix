{ config, lib, ... }:{
  imports = [
    ./config.nix
    ./aliases.nix
    # ./hotkeys.nix
    ./skins.nix
  ];

  config = lib.mkIf config._.kube {
    programs.k9s = {
      enable   = true;
      settings = {};
      aliases  = {};
      hotKeys  = {};
      plugins  = {};
      views    = {};
      skins    = {};
    };
  };
}
