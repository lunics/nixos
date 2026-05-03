{
  services.lidarr = {
    enable       = true;
    user         = "lidarr";
    group        = "lidarr";
    # environmentFiles = [];    # file to pass secret configuration values, https://wiki.servarr.com/useful-tools#using-environment-variables-for-config
    openFirewall = false;
    dataDir      = "/var/lib/lidarr/.config/Lidarr";
    settings = {
      server = {
        urlbase     = "localhost";
        port        = 8686;
        bindaddress = "*";
      };
    };
  };
}
