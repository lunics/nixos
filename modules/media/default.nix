{ pkgs, ... }:{ 
  imports = [
    ./instagram.nix
    ./yt-x.nix
  ];

  home.packages = with pkgs; [
    playerctl
    freetube
    spotify
    streamlink-twitch-gui-bin
    mpv
  ];
}
