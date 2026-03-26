{ config, lib, ... }:{
  config = lib.mkIf config._.microvm.enable {
    networking.nat = {
      enable             = true;                    # nat ipv4
      enableIPv6         = config._.microvm.ipv6;   # nat ipv6
      externalInterface  = "wlan0";                 # interface connected to the router
      internalInterfaces = [ "microvm-net-2" ];     # interface connected to the machines
      # internalIPs        = [ "10.0.0.0/24" ];
      # forwardPorts = [
      #   { # forwards TCP ports 80 of host to microvm domain
      #     proto       = "tcp";
      #     sourcePort  = 80;
      #     destination = "10.0.0.1:80";
      #       or
      #     destination = my-addresses.http-reverse-proxy.ip4;
      #   }
      #   {# forwards TCP ports 443 of host to microvm domain
      #     proto       = "tcp";
      #     sourcePort  = 443;
      #     destination = "[fc00::2]:80";
      #       or
      #     destination = my-addresses.https-reverse-proxy.ip4;
      #   }
      # ];
    };
  };
}
