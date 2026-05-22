{
  flake.aspects.podman.nixos = { config, lib, ... }:{
    config = lib.mkIf config._.podman {
      virtualisation.podman = {
        enable        = true;
        dockerCompat  = true;                           # alias mapping docker to podman
        enableNvidia  = false;                          # deprecated, use hardware.nvidia-container-toolkit.enable instead
        extraPackages = [];
        defaultNetwork.settings.dns_enabled = true;    # required for containers under podman-compose to be able to talk to each other
        dockerSocket.enable = false;                   # podman socket available in place of the Docker socket; users must be in the podman group
        autoPrune = {
          enable = false;
          dates  = "weekly";
          flags  = [];
        };
        networkSocket = {
          enable        = false;
          listenAddress = "0.0.0.0";
          openFirewall  = false;
          port          = 2376;
          # server      = "";         # TLS proxy server
        };
      };
    };
  };
}
