{
  services.immich = {
    enable = true;
    user = "immich";
    group = "immich";
    host = "localhost";
    mediaLocation = "/var/lib/immich";
    openFirewall = false;
    port = 2283;

    # Path of a file with extra environment variables to be loaded from disk. This file is not added to the nix store, so it can be used to pass secrets to immich
    secretsFile = "/run/secrets/immich";

    # https://immich.app/docs/install/config-file/ or https://my.immich.app/admin/system-settings
    settings = {
      server.externalDomain = "";
      newVersionCheck.enabled = false;
    };

    database

    # environment = {
    #   IMMICH_LOG_LEVEL = "verbose";
    # }
    # accelerationDevices = [ "/dev/dri/renderD128" ]
  };
}
