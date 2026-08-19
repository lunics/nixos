{
  flake.aspects.media.homeManager = { config, lib, pkgs, ... }: let
    cfg = config._.spotify;

    prefs = pkgs.writeText "spotify-prefs" ''
      autologin.username="${cfg.username}"
      autologin.saved_credentials="{\"${cfg.username}\":[\"${cfg.username}\",\"${cfg.token}\"]}"
      autologin.canonical_username="${cfg.username}"
      autologin.blob="${cfg.token}"
      es.send-on-startup=true
      core.clock_delta=0
      storage.last-location="/home/${config._.user}/.cache/spotify/Storage"
      app.last-launched-version="${pkgs.spotify.version}"
    '';

    # Spotify rewrites ~/.config/spotify/prefs on every start and exit, so a
    # home-manager symlink there gets clobbered. Only the content at startup
    # matters for autologin, so drop a fresh writable copy in place right
    # before the app launches instead of trying to keep the file read-only.
    spotify = pkgs.symlinkJoin {
      name  = "spotify-${pkgs.spotify.version}";
      paths = [ pkgs.spotify ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/spotify \
          --run '${pkgs.coreutils}/bin/install -Dm600 ${prefs} ${config.xdg.configHome}/spotify/prefs'
      '';
    };
  in {
    _.allow-unfree = [
      (if cfg.token == null then pkgs.spotify else spotify)
    ];

    programs.spotify-player = {
      enable   = true;
      package = pkgs.spotify-player.override {
        withFuzzy = true;
      };
      settings = {
        enable_audio_visualization = false;
        play_icon  = "▶";
        pause_icon = "▌▌";
        liked_icon = "♥";
      };
      keymaps  = [{
        command      = "LyricsPage";
        key_sequence = "L";
      }{
        command      = "PreviousPage";
        key_sequence = "esc";
      }];
      actions  = [];
      themes   = [];
    };
  };
}
