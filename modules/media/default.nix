{ pkgs, inputs, ... }:{ 
  home.packages = with pkgs; [
    playerctl
    freetube
    spotify
    streamlink-twitch-gui-bin
    mpv
    inputs.yt-x.packages."${system}".default
      # link ~/.config/yt-x/recent.json to share folder
    yt-dlp
  ];
}
