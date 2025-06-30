{
  xdg = {
    enable = true;

    autostart = {
      enable  = true;
      entries = [
        "${pkgs.evolution}/share/applications/org.gnome.Evolution.desktop"
      ];
      readOnly= false;      # readonly directory so that programs cannot install arbitrary autostart services
    };

    desktopEntries = {      #  Entries allow applications to be shown in your desktop environment's app launcher
      firefox = {
        name        = "Firefox";
        genericName = "Web Browser";
        exec        = "firefox %U";
        terminal    = false;
        categories  = [ "Application" "Network" "WebBrowser" ];
        mimeType    = [ "text/html" "text/xml" ];
      };
    };

    userDirs = {
    };

    configHome = "~/.config";         # XDG_CONFIG_HOME
    # configFile = {}                 # XDG_CONFIG_HOME's list of files
    cacheHome  = "~/.cache";          # XDG_CACHE_HOME
    # cacheFile = {}                  # XDG_CACHE_HOME's list of files
    dataHome   = "~/.local/share";    # XDG_DATA_HOME
    # dataFile = {}                   # XDG_DATA_HOME's list of files
    stateHome  = "~/.local/state";    # XDG_STATE_HOME
    # stateFile = {}                  # XDG_STATE_HOME's list of files
  };
}
