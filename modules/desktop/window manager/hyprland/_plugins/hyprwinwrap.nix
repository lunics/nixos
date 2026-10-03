{
  flake.aspects.hyprland.homeManager = { pkgs, ... }:{ # any app as wallpaper
    wayland.windowManager.hyprland.plugins = [
      pkgs.hyprlandPlugins.hyprwinwrap
    ];
  };
}
