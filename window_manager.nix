{
  wayland.windowManager.hyprland = {
    plugins = [
      plugins.hyprexpo
      plugins.hyprbars
      plugins.hyprwinwrap
      plugins.hyprtrails
    ];
    enable = true;
    systemd.enable = true;
    # xwayland.enable = true;
  };
}
