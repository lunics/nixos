{
  flake.aspects.docker.nixos = { config, lib, pkgs, ... }:{
    config = lib.mkIf config._.docker {
      virtualisation.docker = {
        enable        = true;
        package       = pkgs.docker;
        # storageDriver = "btrfs";      # null, aufs, btrfs, devicemapper, overlay, overlay2, zfs
                                        # changing the storage driver will cause existing containers and images to become inaccessible
        rootless = {
          enable            = false;
          package           = pkgs.docker;
          setSocketVariable = true;     # point DOCKER_HOST to rootless Docker instance for normal users by default
          extraPackages     = [];
          daemon.settings = {
            # fixed-cidr-v6 = "fd00::/80";
            # ipv6 = true;
          };
        };

        daemon.settings = {
          live-restore    = true;       # allow dockerd to be restarted without affecting running containers — incompatible with docker swarm
          # userland-proxy  = false;
          # experimental    = true;
          # ipv6            = true;
          # "fixed-cidr-v6" = "fd00::/80";
        };

        autoPrune = {
          enable             = true;
          dates              = "weekly";
          persistent         = true;
          randomizedDelaySec = "0";
          flags              = [];
        };

        enableOnBoot  = true;
        listenOptions = [ "/run/docker.sock" ];
        logDriver     = "journald";     # none, json-file, syslog, journald, gelf, fluentd, awslogs, splunk, etwlogs, gcplogs, local

        extraPackages = [];             # extra packages to add to PATH for the docker daemon process
        extraOptions  = "";             # extra command-line options to pass to docker daemon
        enableNvidia  = false;          # deprecated, use hardware.nvidia-container-toolkit.enable instead
      };

      users.extraGroups.docker.members = [ "${config._.user}" ];

      environment.systemPackages = with pkgs; [
        docker-compose
        lazydocker
      ];
    };
  };
}
