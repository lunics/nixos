{
  flake.aspects.wallpaper.homeManager = { pkgs, ... }:{
    home.packages = with pkgs; [
      awww    # to get awww-daemon
    ];

    _.add_to_startup = [ "awww-daemon --quiet" ];
  };
}
