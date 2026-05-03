{ pkgs, ... }:{
  imports = [
    ./editor_config.nix
    ./neovim
    ./joplin.nix
  ];

  # home.packages = with pkgs; [
  #   anytype         # p2p note-taking tool
  #   anytype-heart   # shared library for Anytype clients
  # ];
}
