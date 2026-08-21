{
  flake.aspects.udiskie.homeManager = { config, pkgs, ... }:{
    services.udiskie = {
      enable    = true;
      package   = pkgs.udiskie;
      automount = true;
      notify    = true;
      tray      = "auto";   # auto, always, never
      settings = {
        icon_names.media = [ "media-optical" "drive-removable-media" "drive-harddisk" ];
        device_config    = config._.udiskie-devices;
      };
    };
    gtk.iconTheme = {       # required by the systray to resolve device icon names
      name    = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
}
