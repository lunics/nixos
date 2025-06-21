{
  services.jellyfin = {
    enable       = true;
    user         = "jellyfin";
    group        = "jellyfin";
    cacheDir     = "var/cache/jellyfin";
    dataDir      = "/var/lib/jellyfin";
    configDir    = "\${cfg.dataDir}/config";
    logDir       = "\${cfg.dataDir}/log";
    openFirewall = false;
  };
}
