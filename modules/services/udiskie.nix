{
  flake.aspects.udiskie.homeManager = { config, pkgs, ... }:{
    services.udiskie = {
      enable    = true;
      package   = pkgs.udiskie;
      automount = true;
      notify    = true;
      tray      = "auto";   # auto, always, never
      settings = {
        icon_names.media = [ "media-optical" ];
        device_config    = config._.udiskie-devices;
      };
    };
  };
}
