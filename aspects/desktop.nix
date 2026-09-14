{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    desktop.includes = with aspects; [
      hyprland
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
      hypridle
      # desktop_manager
    ];
  };
}
