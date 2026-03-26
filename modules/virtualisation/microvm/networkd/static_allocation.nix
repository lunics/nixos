{ config, lib, ... }:{
  config = lib.mkIf config._.microvm.enable {
    systemd.network = {
      networks = {
        # routed TAP
        "30-vm" = {
          matchConfig.Name = "microvm-*";
          address = [
            "10.0.0.0/32"       # Assign IP 10.0.0.0 to the host side of the interface (/32 = no subnet, point-to-point)
            # "fec0::/128"
          ];
          routes = [            # setup routes to the VM
            { Destination = "10.0.0.1/32"; }      # because we are in /32, this is not really a route by the final already the final VM's IP
                                                  # Tells the host: "to reach 10.0.0.1, use this vm-* interface" 10.0.0.1 would be the VM's IP address
            # { Destination = "fec0::${lib.toHexString index}/128"; } 
          ];
          networkConfig = {                       # enable routing
            DHCPServer     = false;
            IPv4Forwarding = true;                # Enable IP forwarding on this interface (acts as a router)
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
            GatewayOnLink = true;           # forces the gateway to be considered reachable without ARP on this link
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
    };
  };
}

