{
  flake.aspects.media.homeManager = { pkgs, ... }:{ 
    home.packages = with pkgs; [
      playerctl
      # streamlink-twitch-gui-bin   # has be removed due to lack on maintence and insecure electro
      mpv
      vlc
    ];
  };
}
