{ pkgs, ... }:{
  ## dynamc input & bind

  programs.swaylock = {
    enable  = true;
    package = pkgs.swaylock-effects;
    settings = {
      daemonize = true;
      screenshots = true;
      indicator = true;
      indicator-radius = 100;
      indicator-thickness = 8;
      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";
      inside-color = "00000000";
      grace = 0;
      fade-in = 0.0;
    };
  };

  home.packages = with pkgs; [
    waypaper
    # hyprpaper  # KO
    # hyprlock    # choose with swaylock
    hyprpicker
    wl-clipboard
    # clipboard-jh      # needs wl-clipboard, KO screen flickering even with: exec-once = cb
    waybar
    brightnessctl
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
