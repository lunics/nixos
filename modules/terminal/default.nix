{ config, ... }:{
  imports = [
    ./alacritty.nix
    ./ghostty.nix
  ];

  home.sessionVariables.TERMINAL = "${config._.terminal}";
}
