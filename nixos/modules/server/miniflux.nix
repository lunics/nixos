{
  services.miniflux = {
    enable       = true;

    # Whether a PostgreSQL database should be automatically created and configured on the local host. If set to false, you need provision a database yourself and make sure to create the hstore extension in it.
    createDatabaseLocally = true;

    config = {
      CLEANUP_FREQUENCY = 48;
      LISTEN_ADDR       = "localhost:8080";
    }

    # File containing the ADMIN_USERNAME and ADMIN_PASSWORD (length >= 6) in the format of an EnvironmentFile=, as described by systemd.exec(5).
    # adminCredentialsFile = "/etc/nixos/miniflux-admin-credentials";   
  };
}

