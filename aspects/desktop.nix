{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    desktop.includes = with aspects; [
      window_manager
      notifier
      wallpaper
      # qt
      # gtk
      font_home
      window_manager
      wallpaper
      status_bar
      screen_locker
      launcher
      # idle_manager
      # desktop_manager
    ];
  };
}
