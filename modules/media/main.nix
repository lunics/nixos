{
  flake.aspects.media.homeManager = { pkgs, ... }:{ 
    home.packages = with pkgs; [
      playerctl
      spotify
      streamlink-twitch-gui-bin
      mpv
      vlc
    ];
  };
}
