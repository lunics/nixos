{ inputs, ... }:{
  flake-file.inputs.dank-material-shell = {
    url = "github:AvengeMedia/DankMaterialShell";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # ## on nixos
  # # required by the evdev to read devices from /dev/input/event*
  # user.users.lunics.extraGroups = [ "input" ];

  flake.aspects.dank-material-shell.homeManager = { config, pkgs, ... }:{
    imports = [ inputs.dank-material-shell.homeModules.dank-material-shell ];

    programs.dank-material-shell = {
      enable = true;
      quickshell.package = pkgs.quickshell;

      settings = {
        theme = "dynamic";       # purple (default), dynamic (based on wallpaper), blue, green, orange, red, cyan, pink, coral, amber
        dynamicTheming = true;
        screenPreferences = {
          wallpaper = [];       # disable wallpaper manager
        };
      };

      # session = {
      #   isLightMode = true;
      # }; 

      clipboardSettings = {
        maxHistory     = 25;
        maxEntrySize   = 5242880;
        autoClearDays  = 1;
        clearAtStartup = true;
        disabled       = false;
        disableHistory = false;
        disablePersist = true;
      };

      systemd = {
        enable = true;                # Systemd service for auto-start
        restartIfChanged = true;      # Auto-restart dms.service when dms-shell changes
        target = config.wayland.systemd.target; # = "graphical-session.target" on hyprland
      };
      
      enableVPN              = true;  # VPN management widget
      enableSystemMonitoring = true;  # System monitoring widgets (dgop)
      enableDynamicTheming   = true;  # Wallpaper-based theming (matugen)
      enableAudioWavelength  = true;  # Audio visualizer (cava)
      enableCalendarEvents   = true;  # Calendar integration (khal)
      enableClipboardPaste   = false;

      plugins = {};
    };
  };
}
