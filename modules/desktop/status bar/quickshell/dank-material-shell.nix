{ inputs, ... }:{
  flake-file.inputs.dank-material-shell = {
    url = "github:AvengeMedia/DankMaterialShell";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.dank-material-shell.homeManager = { pkgs, ... }:{
    imports = [ inputs.dank-material-shell.homeModules.dank-material-shell ];

    programs.dms-shell = {
      enable = true;
      quickshell.package = pkgs.quickshell;
    
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
