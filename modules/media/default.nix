{ pkgs, ... }:{ 
  home.packages = with pkgs; [
    playerctl
    freetube
    spotify
    streamlink-twitch-gui-bin
    mpv
    instaloader       # dl insta videos/pictures with metadatas
  ];

  imports = [
    ./yt-x.nix
  ];
}
