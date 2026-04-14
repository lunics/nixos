{ config, lib, ... }:{
  config = lib.mkIf config._.microvm.enable {
    systemd.network = {
      networks = {
        "10-microvm-tap" = {            # one network to matches ALL microvm-net-* TAPs
          matchConfig.Name = "mvm-*";
          address = [ "10.0.0.1/24" ];  # host IP of the TAPs, where each VM sets it as its default gateway
          # address = [
          #   "10.0.0.0/32"       # Assign IP 10.0.0.0 to the host side of the interface (/32 = no subnet, point-to-point)
          #   # "fec0::/128"
          # ];
          # routes = [            # setup routes to the VM
          #   { Destination = "10.0.0.1/32"; }      # because we are in /32, this is not really a route by the final already the final VM's IP
          #                                         # Tells the host: "to reach 10.0.0.1, use this vm-* interface" 10.0.0.1 would be the VM's IP address
          #   # { Destination = "fec0::${lib.toHexString index}/128"; } 
          # ];
          networkConfig = {                       # enable routing
            DHCPServer     = false;
            IPv4Forwarding = true;                # Enable IP forwarding on this interface (acts as a router)
            IPv6Forwarding = config._.microvm.ipv6;
          };
          # linkConfig.RequiredForOnline = false;  # uncomment if boot hang waiting for the TAPs to be ready
        };
      };
    };
  };
}

