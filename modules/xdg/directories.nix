{ config, lib, ... }:{
  home.activation.home-dirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ${config._.logs}
  '';

  home.sessionVariables = rec {
    XDG_BIN_HOME          = "${config._.home}/.local/bin";
    XDG_SCREENSHOTS_DIR   = "${config._.share}/screenshots";
  };

  xdg = {
    configHome = "${config._.home}/.config";         # XDG_CONFIG_HOME
    cacheHome  = "${config._.home}/.cache";          # XDG_CACHE_HOME
    dataHome   = "${config._.home}/.local/share";    # XDG_DATA_HOME
    stateHome  = "${config._.home}/.local/state";    # XDG_STATE_HOME
    # configFile = {}                     # XDG_CONFIG_HOME's list of files
    # cacheFile = {}                      # XDG_CACHE_HOME's list of files
    # dataFile = {}                       # XDG_DATA_HOME's list of files
    # stateFile  = {                      # XDG_STATE_HOME's list of files
    #   NAME = {
    #     enable      = true;             # whether this file should be generated
    #     executable  = null;             # null = defaults to the mode of the source, true = set the execute bit
    #     force       = false;            # the target path should be unconditionally replaced by the managed file source, will silently delete the target
    #     ignorelinks = false;            # adds -ignorelinks flag to lndir
    #     onChange    = "";
    #     recursive   = false;
    #     source      = absolute path;    # Path of the source file or directory
    #     target      = "NAME";           # Path to target file relative to .
    #     text        = null;
    #   };
    # };

    userDirs = {
      enable            = true;
      createDirectories = true;
      download          = config._.downloads; # XDG_DOWNLOAD_DIR
      music             = null;   # XDG_MUSIC_DIR
      desktop           = null;   # XDG_DESKTOP_DIR
      documents         = null;   # XDG_DOCUMENTS_DIR
      pictures          = null;   # XDG_PICTURES_DIR
      publicShare       = null;   # XDG_PUBLICSHARE_DIR
      templates         = null;   # XDG_TEMPLATES_DIR
      videos            = null;   # XDG_VIDEOS_DIR
      # extraConfig = {
      #   XDG_MISC_DIR = "${config.home.homeDirectory}/Misc";
      # };
    };

    systemDirs = {
      config = [      # XDG_CONFIG_DIRS
        # "/etc/xdg"
      ];                    
      data   = [      # XDG_DATA_DIRS
        # XDG_DATA_DIRS         = "/usr/local/share:/usr/share:/var/lib/flatpak/exports/share:/home/$USER/.local/share/flatpak/exports/share";
        # "/usr/share"
        # "/usr/local/share"
      ];
    };
  };
}
