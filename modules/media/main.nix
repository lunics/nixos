{
  flake.aspects.media.homeManager = { pkgs, ... }:{ 
    home.packages = with pkgs; [
      playerctl
      # spotify   # KO Could not resolve host: api.snapcraft.io
      streamlink-twitch-gui-bin
      mpv
      vlc
    ];
  };
}
