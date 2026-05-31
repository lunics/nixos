{
  flake.aspects.media.homeManager = { pkgs, ... }:{ 
    home.packages = with pkgs; [
      playerctl
      streamlink-twitch-gui-bin
      mpv
      vlc
    ];

    _.allow-unfree = with pkgs; [
      spotify
    ];
  };
}
