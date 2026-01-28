{ config, pkgs, ... }:{
  imports = [
    ./alacritty.nix
    ./ghostty.nix
  ];

  home.sessionVariables.TERMINAL = "${config._.terminal}";

  _.add_to_startup = [ config._.terminal ];
  # "/home/lunics/.local/share/devbox/global/default/.devbox/nix/profile/default/bin/ghostty"
}
