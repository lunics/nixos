{ pkgs, ... }:{
  home.packages = with pkgs; [
    libnotify
  ];

  services.dunst = {
    enable         = true;
    package        = pkgs.dunst;
    waylandDisplay = "wayland-1";
    # fullscreen_delay_everything = { fullscreen = "delay"; }; ??
  
    iconTheme = {
      # name    = "Papirus-Dark";
      # package = pkgs.papirus-icon-theme; };
      name    = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size    = "16x16"; };
  
    settings = {
      global = {
        origin              = "top-center";  # top-center, top-right
        # transparency      = 60;         # KO; 0 to 100 in percentage, not available on wayland only X11
        # rounded           = "yes";      # KO

        format    = "%I %s %p\\n%b";
        # format  = "<b>%s</b>\\n%b"; #format = "<span foreground='#f3f4f5'><b>%s %p</b></span>\n%b"
        # %a  appname
        # %s  summary
        # %b  body
        # %i  iconname (including its path)
        # %I  iconname (without its path)
        # %p  progress value if set ([  0%] to [100%]) or nothing
        # Markup is allowed

        alignment           = "left";         # left, center, right
        indicate_hidden     = "yes";          # Show how many messages are currently hidden

        # The frequency with which text that is longer than the notification
        # window allows bounces back and forth.
        # This option conflicts with "word_wrap".
        # Set to 0 to disable.
        # bounce_freq         = 5;        ## KO
        word_wrap           = "yes";      # Split notifications into multiple lines if they don't fit into geometry

        # allow_markup        = "yes";    # Allow a subset of html      ## KO
        show_age_threshold  = 60;     # Show age of message if message is older than show_age_threshold

        ignore_newline      = "no";   # Ignore newlines '\n' in notifications.
        monitor             = "0";
        vertical_alignment  = "center";
        width               = "400";
        height              = "(0, 400)";
        scale               = 0;
        gap_size            = 0;
        progress_bar        = true;
        text_icon_padding   = 0;
        separator_color     = "frame";
        sort                = "yes";      # Sort by urgency
        idle_threshold      = 120;
        line_height         = 0;
        markup              = "full";
        ellipsize           = "middle";
        stack_duplicates    = true;
        sticky_history      = "yes";
        history_length      = 20;
        always_run_script   = true;
        corner_radius       = 10;
        follow              = "mouse";
        font                = "Source Sans Pro 10";

        frame_color         = "#00FF00";
        frame_width         = 1;
        timeout             = 4;

        offset              = "15x15";
        horizontal_padding  = 10;
        icon_position       = "left";
        min_icon_size       = 0;
        max_icon_size       = 64;
        mouse_left_click    = "do_action, close_current";
        mouse_middle_click  = "close_current";
        mouse_right_click   = "close_all";
        padding             = 10;
        # plain_text          = "no";       ## KO
        separator_height    = 2;
        show_indicators     = "yes";
        shrink              = "no";     # Shrink window if it's smaller than the width. Ignored if width is 0
        browser             = "/usr/bin/env firefox -new-tab";
      };

      # format: RRGGBBAA
      urgency_critical = {
        background = "#D64E4EAA";
        foreground = "#F0E0E0AA";
      };

      urgency_normal = {
        background = "#1E1E2AAA";
        foreground = "#2596BEAA";
        # foreground = "#DCD7BA";
        # highlight  = "#6A9589"
        # frame_color = "#7FB4CA";
        # timeout    = 4;
        # default_icon = /home/dex/.local/share/icons/Fluent-dark/symbolic/status/notifications-new-symbolic.svg
      };

      urgency_low = {
        background = "#232323AA";
        foreground = "#2596BEAA";
      };
    };
  };
}
