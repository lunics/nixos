{
  flake.aspects.networkd.nixos = { config, lib, ... }:{
    config = lib.mkIf config._.microvm.enable {
      networking = {
        useNetworkd = true;   # alias of systemd.network.enable = true
        networkmanager.unmanaged = [ "interface-name:mvm-*" ]; # force NetworkManager to ignore the TAP interfaces to avoid conflicts
      };

      # files generated in /etc/systemd/network
      systemd.network = {
        enable = true;
        config = {
          addRouteTablesToIPRoute2 = true;
          networkConfig = {
            IPv6PrivacyExtensions = config._.microvm.ipv6;
          };
          routeTables  = {};
          dhcpV6Config = {};
          dhcpV4Config = {};
        };
        wait-online = {
          enable       = true;
          anyInterface = config.networking.useDHCP;
          timeout      = 120;
          extraArgs    = [];
          ignoredInterfaces = [];
        };
        links    = {};
        netdevs  = {};
        networks = {};
      };
    };
  };
}
