{ pkgs, ... }:{
  ## dynamc input & bind
  programs = {

    wayprompt = {
      enable   = true;
      package  = pkgs.wayprompt;
      # settings = {
      #   general = {
      #     font-regular = "sans:size=14";
      #     pin-square-amount = 32;
      #   };
      #   colours = {
      #     background = "ffffffaa";
      #   };
      # };
    };
  };


  home.packages = with pkgs; [
    waypaper
    # hyprpaper  # KO
    # hyprlock   # choose with swaylock
    hyprpicker
    wl-clipboard
    # wl-clipboard-rs   # KO to install
                        # collision between `/nix/store/y89kpm6rk0kib5rg8mkwcvhq5h6v2jyi-wl-clipboard-2.2.1/bin/wl-copy' and `/nix/store/jwafgnncls2lyx0jpxy5pfij7bm3ixh2-wl-clipboard-rs-0.9.1/bin/wl-copy'
    # clipboard-jh      # needs wl-clipboard, KO screen flickering even with: exec-once = cb
    brightnessctl
    grimblast           # grim + slurp to take screenshot
  ];

  xdg.configFile = {
    "hypr" = {
      recursive = true;
      source    = ./hypr;
    };

    "hypr/config.d/bind".text = builtins.readFile ./hypr/binds/bind_azerty;
    # "hypr/config.d/bind".text = builtins.readFile ./hypr/binds/bind_splitkb;

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
