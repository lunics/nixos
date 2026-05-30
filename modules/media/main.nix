{
  flake.aspects.media.homeManager = { pkgs, ... }:{ 
    home.packages = with pkgs; [
      playerctl
      streamlink-twitch-gui-bin
      mpv
      vlc
    ];
  };
}
