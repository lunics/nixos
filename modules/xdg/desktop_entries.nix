{ pkgs, ... }:{
  xdg.desktopEntries = {      #  Entries allow applications to be shown in your desktop environment's app launcher
    firefox = {
      name        = "Firefox";
      genericName = "Web Browser";
      exec        = "firefox %U";
      icon = null;    # Icon to display in file manager, menus, etc.
      terminal    = false;
      categories  = [ "Application" "Network" "WebBrowser" ];
      mimeType    = [ "text/html" "text/xml" ];     # MIME type(s) supported by this application
      comment     = "";                 # tooltip for the entry
      terminal    = false;              # whether the program runs in a terminal window
      type        = "Application";      # application, Link or Directory. type of the desktop entry
      startupNotify = null;             # if true, it is KNOWN that the application will send a "remove" message when started with the DESKTOP_STARTUP_ID environment variable set. If false, it is KNOWN that the application does not work with startup notification at all
      # actions = {                     # set of actions made available to application launchers
      #   "New Window" = {
      #     exec = "${pkgs.firefox}/bin/firefox --new-window %u";
      #     icone = "";
      #     name = "";                  # program to execute, possibly with arguments
      #   };
      # };
      settings = {                      # key-value pairs to add to the [Desktop Entry] section. This may override other values
        Keywords        = "calc;math";
        DBusActivatable = "false";
      };
      prefersNonDefaultGPU = null;      # If true, the application prefers to be run on a more powerful discrete GPU if available
      noDisplay = null;                 # this application exists, but don't display it in the menus
    };
  };
}
