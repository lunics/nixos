{ config, lib, ... }:{
  config = lib.mkIf config._.microvm.enable {
    networking.nat = {
      enable             = true;
      # enableIPv6       = true;              # enable ipv6 nat
      externalInterface  = "wlan0";           # interface connected to the router
      internalIPs        = [ "10.0.0.0/24" ];
      # internalInterfaces = [ "br0-microvm" ]; # interface connected to the machines
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
