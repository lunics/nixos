{ pkgs, ... }:{
  imports = [
    ./editor_config.nix
    ./neovim
  ];

  home.packages = with pkgs; [
    anytype
  ];
}
