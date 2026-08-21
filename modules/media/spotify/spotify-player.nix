{
  flake.aspects.media.homeManager = { pkgs, ... }:{
    xdg.configFile."spotify-player/app.toml".force = true;

    programs.spotify-player = {
      enable   = true;
      package = pkgs.spotify-player.override {
        withFuzzy = true;
      };
      settings = {
        enable_notify = false;
        enable_audio_visualization = false;
        play_icon  = "▌▌";
        pause_icon = "▶";
        liked_icon = "♥";
        explicit_icon = "E";
        theme = "dracula";
        client_id = "d420a117a32841c2b3474932e49fb54b";
        client_port = 8080;
        login_redirect_uri = "http://127.0.0.1:8989/login";
        playback_format = ''
        {status} {track} • {artists} {liked}
        {album} • {genres}
        {metadata}'';
        playback_metadata_fields = [
          "repeat"
          "shuffle"
          "volume"
          "device"
        ];
        notify_timeout_in_secs = 0;
        notify_transient = false;
        tracks_playback_limit = 50;
        app_refresh_duration_in_ms = 32;
        playback_refresh_duration_in_ms = 0;
        page_size_in_rows = 20;
        border_type = "Plain";
        progress_bar_type = "Rectangle";
        progress_bar_position = "Bottom";
        genre_num = 2;
        cover_img_length = 0;
        cover_img_width = 5;
        enable_media_control = true;
        enable_streaming = "Always";
        enable_cover_image_cache = true;
        notify_streaming_only = false;
        seek_duration_secs = 5;
        sort_artist_albums_by_type = false;
        volume_scroll_step = 5;
        enable_mouse_scroll_volume = true;
        custom_queue = true;
        enable_relative_line_number = false;
        pause_on_startup = false;
        notify_format = {
          summary = "{track} • {artists}";
          body = "{album}";
        };
        layout = {
          playback_window_position = "Top";
          playback_window_height = 6;
          
          library = {
            playlist_percent = 40;
            album_percent = 40;
          };
        };
        device = {
          name          = "spotify-player";
          device_type   = "speaker";
          volume        = 70;
          bitrate       = 320;
          audio_cache   = false;
          normalization = false;
          autoplay      = false;
        };
      };
      keymaps  = [{
        key_sequence = "L";
        command      = "LyricsPage";
      }{
        key_sequence = "esc";
        command      = "PreviousPage";
      }{
        key_sequence = "f";
        command      = "Search";
      }{
        key_sequence = "/";
        command      = "None";    # unbind / for Search
      }{
        key_sequence = "l";
        command      = "FocusNextWindow";
      }{
        key_sequence = "h";
        command      = "FocusPreviousWindow";
      }];
      actions  = [];
      themes   = [];
    };
  };
}
