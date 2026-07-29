{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    desktop.includes = with aspects; [
      window_manager
      notifier
      wallpaper
      # qt
      gtk
      font_home

      # STATUS BAR
      # hyprpanel
      quickshell
      # caelestia

      screen_locker
      launcher
      # idle_manager
      # desktop_manager
    ];
  };
}
