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
            IPv6PrivacyExtensions = config._.net.ipv6;
          };
          routeTables  = {};
          dhcpV6Config = {};
          dhcpV4Config = {};
        };
        # the microvm bridge has no carrier while no VM runs, so --any never sees a link
        # online and stalls the switch; NetworkManager already owns the real links
        wait-online = {
          enable       = false;
          anyInterface = config.networking.useDHCP;
          timeout      = 30;
          extraArgs    = [];
          ignoredInterfaces = [ "mvm-*" ];
        };
        links    = {};
        netdevs  = {};
        networks = {};
      };
    };
  };
}
