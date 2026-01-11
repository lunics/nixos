{ config, lib, pkgs, ... }:{
  config = lib.mkIf (config._.podman) {
    services.podman = {         # daemonless container engine
      enable      = true;
      package     = pkgs.podman;
      builds      = {};
      containers  = {};
      volumes     = {};
      networks    = {};
      images      = {};

      enableTypeChecks = false;

      settings = {
        containers = {};        # TOML value
        registries = {
          block    = [];        # blocked repositories
          insecure = [];        # insecure repositories
          search   = [          # repositories to search
            "docker.io"
            "quay.io"
          ];
        };
        policy = {};            # signature verification policy file
        mounts = [];            # mounts.conf configuration
        # storage               # TOML value
      };

      autoUpdate = {
        enable     = false;             # auto update podman images
        onCalendar = "Sun *-*-* 00:00";
      };
    };

    home.packages = with pkgs; [
      podman-compose
      # lazydocker
      # pods            # gui
      # podman-tui    # user lazydocker instead
    ];
  };
}
