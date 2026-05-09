{ pkgs, ... }:{
  # run: pkg search hyprlandPlugins
  wayland.windowManager.hyprland.plugins = [ 
    # hyprlandPlugins.hycov             # tile all of your windows in a single workspace via grid layout
    # hyprlandPlugins.hyprgrass         # gestures for touch screen
    # hyprlandPlugins.hyprfocus         # flash focus windows on hover
    # hyprlandPlugins.hyprbars          # adds title bars to windows
    # hyprexpo
    # hyprbars
    # hyprtrails
  ];
}
