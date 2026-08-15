{
  flake.aspects.media.homeManager = { config, lib, pkgs, ... }:{ 
    config = lib.mkMerge [{
      _.allow-unfree = with pkgs; [
        spotify
      ];

    }(lib.mkIf (config._.spotify.token != null) {
      xdg.configFile."spotify/prefs".text = ''
        autologin.blob="${config._.spotify.token}"
        autologin.canonical_username="${config._.spotify.username}"
        autologin.saved_credentials="{\"${config._.spotify.username}\":[\"${config._.spotify.username}\",\"${config._.spotify.token}\"]}"
        es.send-on-startup=true
        core.clock_delta=0
        storage.last-location="/home/${config._.user}/.cache/spotify/Storage"
        autologin.username="${config._.spotify.username}"
        app.last-launched-version="${pkgs.spotify.version}"
      '';
    })];
  };
}
