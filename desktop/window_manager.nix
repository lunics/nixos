{ pkgs, ... }:{
  ## dynamc input & bind

  home.packages = with pkgs; [
    waypaper
    # hyprpaper  KO
    hyprlock
    hyprpicker
    wl-clipboard
    waybar
  ];

  xdg.configFile = {
    "hypr" = {
      recursive = true;
      source = ../files/hypr;
    };

    "hypr/config.d/bind".text = builtins.readFile ../files/hypr/binds/bind_azerty;
    # "hypr/config.d/bind".text = builtins.readFile ../files/hypr/binds/bind_splitkb;

    # "hypr/config.d/bind".text = ''
    #   splash = false
    #   preload = ${wallpaper}
    #   wallpaper = DP-1, ${wallpaper}
    #   wallpaper = eDP-1, ${wallpaper}
    # '';
  };
}

  # wayland.windowManager.hyprland = {
  #   plugins = [
  #     plugins.hyprexpo
  #     plugins.hyprbars
  #     plugins.hyprwinwrap
  #     plugins.hyprtrails
  #   ];
  #   enable = true;
  #   systemd.enable = true;
  #   # xwayland.enable = true;
  #
  #   # extraConfig = ''
  #   #   ${builtins.readFile ./config.conf}
  #   #   ${builtins.readFile ./file2.conf}
  #   # '';
  #
  # };
