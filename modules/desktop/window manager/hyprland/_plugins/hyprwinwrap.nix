{
  flake.aspects._plugins.homeManager = { # any app as wallpaper
    wayland.windowManager.hyprland.plugins = [ 
      hyprlandPlugins.hyprwinwrap       
    ];
  };
}
