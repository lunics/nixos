{
  flake.aspects.window_manager.homeManager = { pkgs, ... }:{
    wayland.windowManager.hyprland = {
      enable          = true;
      package         = null;    # must be null to force using the pkg from nixos/system module
      portalPackage   = null;    # //
      xwayland.enable = true;
      sourceFirst     = true;    # enable putting source entries at the top of the configuration

      extraLuaFiles.main.content = ''
        ${builtins.readFile ./config.d/animations.lua}
        ${builtins.readFile ./config.d/decoration.lua}
        ${builtins.readFile ./config.d/dwindle.lua}
        ${builtins.readFile ./config.d/general.lua}
        ${builtins.readFile ./config.d/gestures.lua}
        ${builtins.readFile ./config.d/master.lua}
        ${builtins.readFile ./config.d/misc.lua}
        ${builtins.readFile ./config.d/monitors.lua}
        -- ${builtins.readFile ./config.d/plugins.lua}
        ${builtins.readFile ./config.d/window_rules.lua}
      '';

      # settings = {
      #   decoration = {
      #     shadow_offset = "0 5";
      #     "col.shadow" = "rgba(00000099)";
      #   };

      #   "$mod" = "SUPER";

      #   bindm = [
      #     # mouse movements
      #     "$mod, mouse:272, movewindow"
      #     "$mod, mouse:273, resizewindow"
      #     "$mod ALT, mouse:272, resizewindow"
      #   ];
      # };

      # finalPackage = {        # the Hyprland package after applying configuration
      #   _type = "literalMD";
      #   text = "`wayland.windowManager.hyprland.package` with applied configuration";
      # };
      # finalPortalPackage
      # importantPrefixes = [
      #   "$"
      #   "bezier"
      #   "name"
      #   "output"
      # ];

      # submaps = {       # to change window focus with vim keys
      #   move_focus = {
      #     settings = {
      #       bind = [
      #         ", h, movefocus, l"
      #         ", j, movefocus, d"
      #         ", k, movefocus, u"
      #         ", l, movefocus, r"

      #         ", escape, submap, reset"
      #       ];
      #     };
      #   };

      #   other_submap = {
      #     settings = {
      #       # ...
      #     };
      #   };
      # };
    };

    #   # "hypr/config.d/bind".text = ''
    #   #   splash = false
    #   #   preload = ${wallpaper}
    #   #   wallpaper = DP-1, ${wallpaper}
    #   #   wallpaper = eDP-1, ${wallpaper}
    #   # '';
    # };

    ## automatically set by Hyprland ?
    # home.sessionVariables.HYPRLAND_INSTANCE_SIGNATURE = "$(hyprctl instances | rg -io '\\b\\w{60,}\\b')";
  };
}
