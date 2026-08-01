{ inputs, ... }:{
  flake-file.inputs.dank-material-shell = {
    url = "github:AvengeMedia/DankMaterialShell";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.dank-material-shell.homeManager = { pkgs, ... }:{
    imports = [ inputs.dank-material-shell.homeModules.dank-material-shell ];

    programs.dank-material-shell = {
      enable = true;
      quickshell.package = pkgs.quickshell;

      settings = {
        theme = "light";
        dynamicTheming = true;
        screenPreferences = {
          wallpaper = [];       # disable wallpaper manager
        };
        useAutoLocation = false; # use the manual weather location below (session.weatherCoordinates)

        barConfigs = [{
          id = "default";
          name = "Main Bar";
          enabled = true;
          position = 0;
          screenPreferences = [ "all" ];
          showOnLastDisplay = true;
          leftWidgets = [ "launcherButton" "workspaceSwitcher" "focusedWindow" ];
          centerWidgets = [ "music" "clock" "weather" ];
          rightWidgets = [ "systemTray" "clipboard" "cpuUsage" "memUsage" "notificationButton" "battery" "controlCenterButton" ];
          spacing = 4;
          innerPadding = 4;
          bottomGap = 0;
          transparency = 0.0;        # <- transparent bar background
          widgetTransparency = 1.0;  # <- modules stay opaque
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
        isLightMode = true;
      }; 

      clipboardSettings = {
        maxHistory = 25;
        maxEntrySize = 5242880;
        autoClearDays = 1;
        clearAtStartup = true;
        disabled = false;
        disableHistory = false;
        disablePersist = true;
      };

      systemd = {
        enable = true;                # Systemd service for auto-start
        restartIfChanged = true;      # Auto-restart dms.service when dms-shell changes
      };
      
      enableSystemMonitoring = true;  # System monitoring widgets (dgop)
      enableVPN = true;               # VPN management widget
      enableDynamicTheming = true;    # Wallpaper-based theming (matugen)
      enableAudioWavelength = true;   # Audio visualizer (cava)
      enableCalendarEvents = true;    # Calendar integration (khal)
    };
  };
}
