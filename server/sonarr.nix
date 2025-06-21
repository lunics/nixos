{
  services.sonarr = {
    enable       = true;
    user         = "sonarr";
    group        = "sonarr";
    # environmentFiles = [];    # https://wiki.servarr.com/useful-tools#using-environment-variables-for-config
    openFirewall = false;
    dataDir      = "/var/lib/sonarr/.config/NzbDrone";
    settings = {
      update = {
        automatically = false;
        mechanism     = "external";     # null or one of "external", "builtIn", "script"
      };
      server.port = 8989;
      log.analyticsEnabled = false;
    };
  };
}
