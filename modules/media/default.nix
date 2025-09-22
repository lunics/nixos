{ pkgs, ... }:{ 
  home.packages = with pkgs; [
    playerctl
    freetube
    spotify
    streamlink-twitch-gui-bin
    mpv
  ];

  imports = [
    ./yt-x.nix
  ];
}
