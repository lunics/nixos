{
  flake.aspects.hyprland.homeManager = { pkgs, ... }:{
    # run: pkg search hyprlandPlugins
    wayland.windowManager.hyprland.plugins = [ 
      # pkgs.hyprlandPlugins.hycov      # tile all of your windows in a single workspace via grid layout
      # pkgs.hyprlandPlugins.hyprgrass  # gestures for touch screen
      # pkgs.hyprlandPlugins.hyprfocus  # flash focus windows on hover
      # pkgs.hyprlandPlugins.hyprbars   # adds title bars to windows
      # hyprexpo
      # hyprbars
      # hyprtrails
    ];
  };
}
