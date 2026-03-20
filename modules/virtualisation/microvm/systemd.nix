{ config, lib, ... }:{
  config = lib.mkIf config._.microvm.enable {
    networking.useNetworkd = true;     # alias of systemd.network.enable = true;

    # files generated in /etc/systemd/network
    systemd.network = {
      enable = true;
      networks = {
        "30-vm" = {
          matchConfig.Name = "microvm-*";
          address = [
            "10.0.0.0/32"
            # "fec0::/128"
          ];
          routes = [            # setup routes to the VM
            { Destination = "10.0.0.1/32"; } 
            # { Destination = "fec0::${lib.toHexString index}/128"; } 
          ];
          networkConfig = {     # enable routing
            IPv4Forwarding = true;
            IPv6Forwarding = config._.microvm.ipv6;
          };
        };

        "10-wlan" = {
          matchConfig.MACAddress = "FE:ED:BA:BE:00:02";
          # static IP configuration
          address = [
            "10.0.0.1/32"
            # "fec0::${lib.toHexString index}/128"
          ];
          routes = [ 
          {
            # a route to the host
            Destination   = "10.0.0.0/32";
            GatewayOnLink = true;
          } 
          {
            # default route
            Destination   = "0.0.0.0/0";
            Gateway       = "10.0.0.0";
            GatewayOnLink = true;
          } 
          # {
          #   # default route
          #   Destination   = "::/0";
          #   Gateway       = "fec0::";
          #   GatewayOnLink = true;
          # } 
          ];
          networkConfig = {
            # DNS servers no longer come from DHCP nor Router
            # Advertisements. Perhaps you want to change the defaults:
            DNS = [
              # quad9.net
              "9.9.9.9"
              "149.112.112.112"
              "2620:fe::fe"
              "2620:fe::9"
            ];
          };
        };
      };
      links = {};
      config = {
        addRouteTablesToIPRoute2 = true;
        networkConfig = {
          IPv6PrivacyExtensions = config._.microvm.ipv6;
        };
        routeTables  = {};
        dhcpV6Config = {};
        dhcpV4Config = {};
      };
    };
  };
}
