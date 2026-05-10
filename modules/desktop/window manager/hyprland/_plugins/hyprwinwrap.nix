{
  flake.aspects.window_manager.homeManager = { # any app as wallpaper
    wayland.windowManager.hyprland.plugins = [ 
      hyprlandPlugins.hyprwinwrap       
    ];
  };
}
