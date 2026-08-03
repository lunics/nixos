{ inputs, ... }:{
  flake-file.inputs.dank-material-shell = {
    url = "github:AvengeMedia/DankMaterialShell";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.dank-material-shell.homeManager = { config, pkgs, ... }:{
    imports = [ inputs.dank-material-shell.homeModules.dank-material-shell ];

    _.status_bar = "dms";

    programs.dank-material-shell = {
      enable = true;
      quickshell.package = pkgs.quickshell;

      settings = {
        theme = "dynamic";       # purple (default), dynamic (based on wallpaper), blue, green, orange, red, cyan, pink, coral, amber
        dynamicTheming = true;
        screenPreferences = {
          wallpaper = [];       # disable wallpaper manager
        };
        useAutoLocation = false; # use the manual weather location below (session.weatherCoordinates)
        showWorkspaceIndex = true;

        barConfigs = [{
          id = "default";
          name = "Main Bar";
          enabled = true;
          position = 0;
          screenPreferences = [ "all" ];
          showOnLastDisplay = true;
          leftWidgets = [ "workspaceSwitcher" ] ++ config._.dms_left_widgets;
          centerWidgets = [ "clock" ];
          rightWidgets = [ 
            "music" 
            "weather" 
            "cpuUsage" 
            "memUsage" 
            "notificationButton" 
            "battery" 
            "controlCenterButton" 
            "systemTray" 
          ];
          spacing = 4;
          innerPadding = 4;
          bottomGap = 0;
          widgetTransparency = 8.0;
          transparency = 0.0;
          squareCorners = false;
          noBackground = false;
          maximizeWidgetIcons = false;
          maximizeWidgetText = false;
          removeWidgetPadding = false;
          widgetPadding = 8;
          gothCornersEnabled = false;
          gothCornerRadiusOverride = false;
          gothCornerRadiusValue = 12;
          borderEnabled = false;
          borderColor = "surfaceText";
          borderOpacity = 1.0;
          borderThickness = 1;
          widgetOutlineEnabled = false;
          widgetOutlineColor = "primary";
          widgetOutlineOpacity = 1.0;
          widgetOutlineThickness = 1;
          fontScale = 1.0;
          iconScale = 1.0;
          autoHide = false;
          autoHideStrict = false;
          autoHideDelay = 250;
          showOnWindowsOpen = false;
          openOnOverview = false;
          visible = true;
          popupGapsAuto = true;
          popupGapsManual = 4;
          maximizeDetection = true;
          useOverlayLayer = false;
          scrollEnabled = true;
          scrollXBehavior = "column";
          scrollYBehavior = "workspace";
          shadowIntensity = 0;
          shadowOpacity = 60;
          shadowColorMode = "default";
          shadowCustomColor = "#000000";
          clickThrough = false;
          hoverPopouts = false;
          hoverPopoutDelay = 150;
        }];
      };

      session = {
        isLightMode          = true;
        nightModeEnabled     = false;
        nightModeAutoEnabled = true;
        nightModeAutoMode    = "time";
        nightModeStartHour   = 21;
        nightModeEndHour     = 6;
        themeModeAutoEnabled = true;
        weatherLocation      = "Paris, France";
        weatherCoordinates   = config._.gps-coordinates;
      };

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
    };
  };
}
