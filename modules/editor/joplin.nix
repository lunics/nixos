{
  flake.aspects.editor.homeManager = { config, pkgs, ... }:{
    _.persistent-home.dirs = [
      ".config/joplin"    # joplin-cli notes database
      ".config/joplin-desktop"
    ];

    programs.joplin-desktop = {
      enable  = false;
      package = pkgs.joplin-desktop;
      general.editor = config._.editor;
      sync = {
        target   = "undefined";   # undefined, none, file-system, onedrive, nextcloud, webdav, dropbox, s3, joplin-server, joplin-cloud
        interval = "undefined";   # undefined, disabled, 5m, 10m, 30m, 1h, 12h, 1d
      };
      extraConfig = {};
    };

    home.packages = with pkgs; [
      joplin-cli
    ];
  };
}
