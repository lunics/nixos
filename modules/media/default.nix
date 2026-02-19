{ pkgs, ... }:{ 
  imports = [
    ./instagram.nix
    ./youtube.nix
  ];

  home.packages = with pkgs; [
    playerctl
    spotify
    streamlink-twitch-gui-bin
    mpv
  ];
}
