{ config, lib, ... }:{
  config = lib.mkIf config._.microvm.enable {
    networking.useNetworkd = true;     # alias of systemd.network.enable = true;

    systemd.network = {
      enable = true;
      netdevs = {
        "bridge-microvm".netdevConfig = {
          Kind = "bridge";
          Name = "br0-microvm";
        };
      };
      networks = {
        "bridge-microvm" = {
          matchConfig.Name = "br0-microvm";
          networkConfig = {
            DHCPServer = true;
            # IPv6SendRA = true;
            # ConfigureWithoutCarrier = true;
          };
          addresses = [ 
            { Address = "10.0.0.1/24"; } 
            # { Address = "fd12:3456:789a::1/64"; } 
          ];
          # ipv6Prefixes = [ 
          #   { Prefix = "fd12:3456:789a::/64"; } 
          # ];
        };

        "tap-microvm" = {
          networkConfig.Bridge = "br0-microvm";
          matchConfig.Name = "microvm-*";
        };

        "30-vm" = {
          matchConfig.Name = "microvm-*";
          address = [
            "10.0.0.0/32"
            # "fec0::/128"
          ];
          # Setup routes to the VM
          routes = [ 
            { Destination = "10.0.0.1/32"; } 
            # { Destination = "fec0::${lib.toHexString index}/128"; } 
          ];
          # Enable routing
          networkConfig = {
            IPv4Forwarding = true;
            # IPv6Forwarding = true;
          };
        };

        "10-wlan" = {
          matchConfig.MACAddress = "FE:ED:BA:BE:00:02";
          # Static IP configuration
          address = [
            "10.0.0.1/32"
            # "fec0::${lib.toHexString index}/128"
          ];
          routes = [ 
          {
            # A route to the host
            Destination = "10.0.0.0/32";
            GatewayOnLink = true;
          } 
          {
            # Default route
            Destination = "0.0.0.0/0";
            Gateway = "10.0.0.0";
            GatewayOnLink = true;
          } 
          # {
          #   # Default route
          #   Destination = "::/0";
          #   Gateway = "fec0::";
          #   GatewayOnLink = true;
          # } 
          ];
          networkConfig = {
            # DNS servers no longer come from DHCP nor Router
            # Advertisements. Perhaps you want to change the defaults:
            DNS = [
              # Quad9.net
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
        # networkConfig = {
        #   IPv6PrivacyExtensions = true;
        # };
        routeTables  = {};
        dhcpV6Config = {};
        dhcpV4Config = {};
      };
    };
  };
}
