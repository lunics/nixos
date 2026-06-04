{ inputs, ... }:{
  flake-file.inputs = {
    hyprland.url     = "github:hyprwm/Hyprland/v0.54.0";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland"; 
    };
  };

  flake.aspects.desktop-nixos.nixos = { config, lib, pkgs, ... }:
  let
    _ = config._;
    wayland-uid = toString config.users.users.${_.wayland_user}.uid;
  in {
    config = lib.mkIf (_.window_manager && _.wayland_user != "" && !_.headless) {
      nix.settings = {
        substituters         = ["https://hyprland.cachix.org"];
        trusted-substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys  = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
      };

      programs.hyprland = {
        enable          = true;
        package         = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage   = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        xwayland.enable = true;
        withUWSM        = true;             # run Hyprland with the UWSM (Universal Wayland Session Manager) session manager
        # systemd.setPath.enable = true;    # only for older version where opening links in applications do not work
      };

      environment.sessionVariables = {
        # WLR_NO_HARDWARE_CURSORS = "1";    # if cursor become invisible
        # DISPLAY = ":0";
        HYPRLAND_LOG_WLR      = "1";
        XCURSOR_SIZE          = "30";               # 24 is good ?
        # XCURSOR_THEME       = "Yaru";

        GDK_BACKEND           = "wayland,x11";      # GTK: Use wayland if available, fall back to x11 if not.
        SDL_VIDEODRIVER       = "wayland";          # Run SDL2 applications on Wayland. Remove or set to x11 if games that provide older versions of SDL cause compatibility issues
        CLUTTER_BACKEND       = "wayland";          # Clutter package already has wayland enabled, this variable will force Clutter applications to try and use the Wayland backend
        NIXOS_OZONE_WL        = "1";                # Hint electron apps on wayland

        QT_AUTO_SCREEN_SCALE_FACTOR = "1";          # (From the QT documentation) enables automatic scaling, based on the monitor's pixel density
        # QT_QPA_PLATFORM:    "wayland;xcb"         # QT: Use wayland if available, fall back to x11 if not.
        QT_QPA_PLATFORMTHEME  = "qt5ct";            # Tells QT based applications to pick your theme from qt5ct, use with Kvantum.
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";  # Disables window decorations on QT applications

        XDG_CURRENT_DESKTOP   = "Hyprland";
        XDG_SESSION_TYPE      = "wayland";
        XDG_SESSION_DESKTOP   = "Hyprland";
        WAYLAND_DISPLAY       = "$(if [[ $UID == '${wayland-uid}' ]]; then ls -l /run/user/${wayland-uid}/ | /run/current-system/sw/bin/grep -IoE 'wayland-[0-9]$'; fi)";
      };
    };
  };
}
