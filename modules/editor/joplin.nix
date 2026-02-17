{ pkgs, ... }:{
  programs.joplin-desktop = {
    enable  = false;
    package = pkgs.joplin-desktop;
    general.editor = "nvim";
    sync = {
      target   = "undefined";   # undefined, none, file-system, onedrive, nextcloud, webdav, dropbox, s3, joplin-server, joplin-cloud
      interval = "undefined";   # undefined, disabled, 5m, 10m, 30m, 1h, 12h, 1d
    };
    extraConfig = {};
  };

  home.packages = with pkgs; [
    joplin-cli
  ];
}
