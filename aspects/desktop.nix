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
      dank-material-shell
      # caelestia

      hyprlock
      launcher
      # idle_manager
      # desktop_manager
    ];
  };
}
