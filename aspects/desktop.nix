{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    desktop.includes = with aspects; [
      # nixos
      xserver
      font
      login-manager
      hyprland            # nixos + home manager

      # home manager
      notifier
      wallpaper
      # qt
      gtk
      font_home

      # STATUS BAR
      # hyprpanel
      dms
      # caelestia

      hyprlock
      launcher
      hypridle
      # desktop_manager
    ];
  };
}
