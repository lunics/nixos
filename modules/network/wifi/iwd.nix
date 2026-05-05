{
  flake.modules.nixos.wifi = { config, lib, ... }:{
    networking.wireless.iwd = {
      enable = true;
      settings = {
        Network = {
          EnableIPv6           = false;
          RoutePriorityOffset  = 200;
          NameResolvingService = "resolvconf";
        };

        Settings = {
          AutoConnect = true;
        };

        General = {
          EnableNetworkConfiguration = true;
        };

        Scan = {
          DisablePeriodicScan = false;
        };
      };
    };

    _.persistent.dirs = lib.mkIf config._.impermanence [
      "/var/lib/iwd"
    ];
  };
}
