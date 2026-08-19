{
  flake.aspects.media.homeManager = { pkgs, ... }:{
    programs.spotify-player = {
      enable   = true;
      package = pkgs.spotify-player.override {
        withFuzzy = true;
      };
      # settings = {
      #   enable_audio_visualization = false;
      #   play_icon  = "▶";
      #   pause_icon = "▌▌";
      #   liked_icon = "♥";
      # };
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
