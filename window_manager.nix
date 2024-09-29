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

    # extraConfig = ''
    #   ${builtins.readFile ./config.conf}
    #   ${builtins.readFile ./file2.conf}
    # '';

  };

}
