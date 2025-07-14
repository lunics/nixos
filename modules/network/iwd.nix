{
  networking.wireless.iwd = {
    enable = true;
    settings = {
      Network = {
        EnableIPv6           = false;
        RoutePriorityOffset  = 200;
        NameResolvingService = "resolvconf"; };

      Settings = {
        AutoConnect = true; };

      General = {
        EnableNetworkConfiguration = true; };

      Scan = {
        DisablePeriodicScan = false; };
    };
  };
}
