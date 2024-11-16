{ config, inputs, pkgs, ... }:{

  ## todo https://haseebmajid.dev/posts/2023-11-15-part-3-hyprland-as-part-of-your-development-workflow/

  programs.hyprland = {
    enable          = true;
    package         = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage   = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true; };

  environment.sessionVariables = {
    # WLR_NO_HARDWARE_CURSORS = "1";    # if cursor become invisible
    # DISPLAY = ":0";
    HYPRLAND_LOG_WLR      = "1";
    XCURSOR_SIZE          = "30";               # 24 is good ?
    # XCURSOR_THEME       = "Yaru";

    GDK_BACKEND           = "wayland,x11";      # GTK: Use wayland if available, fall back to x11 if not.
    SDL_VIDEODRIVER       = "wayland";          # Run SDL2 applications on Wayland. Remove or set to x11 if games that provide older versions of SDL cause compatibility issues
    CLUTTER_BACKEND       = "wayland";          # Clutter package already has wayland enabled, this variable will force Clutter applications to try and use the Wayland backend

    QT_AUTO_SCREEN_SCALE_FACTOR = "1";          # (From the QT documentation) enables automatic scaling, based on the monitor’s pixel density
    # QT_QPA_PLATFORM:    "wayland;xcb"         # QT: Use wayland if available, fall back to x11 if not.
    QT_QPA_PLATFORMTHEME  = "qt5ct";            # Tells QT based applications to pick your theme from qt5ct, use with Kvantum.
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";  # Disables window decorations on QT applications

    XDG_CURRENT_DESKTOP   = "Hyprland";
    XDG_SESSION_TYPE      = "wayland";
    XDG_SESSION_DESKTOP   = "Hyprland";
    NIXOS_OZONE_WL        = "1";                # Hint electron apps on wayland
  };
}
