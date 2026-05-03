{
  services.radarr = {
    enable       = true;
    user         = "radarr";
    group        = "radarr";
    # environmentFiles = [];    # file to pass secret configuration values, https://wiki.servarr.com/useful-tools#using-environment-variables-for-config
    openFirewall = false;
    dataDir      = "/var/lib/radarr/.config/Radarr";
    settings = {
      update.mechanism = "internal";
      server = {
        urlbase     = "localhost";
        port        = 7878;
        bindaddress = "*";
      };
    };
  };
}
