{ pkgs, ... }:{
  imports = [
    ./editor_config.nix
    ./neovim
    ./joplin.nix
  ];

  home.packages = with pkgs; [
    anytype
  ];
}
