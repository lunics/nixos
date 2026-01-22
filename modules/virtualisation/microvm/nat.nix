{ config, lib, ... }:{
  config = lib.mkIf config._.microvm.enable {
    networking.nat = {
      enable             = true;
      enableIPv6         = true;              # whether to enable ipv6 nat
      externalInterface  = "wlan0";           # interface connected to the router
      internalInterfaces = [ "microvm" ];     # interface connected to the machine B
      # forwardPorts = [
      #   { # forwards TCP ports 80 of host to microvm domain
      #     proto       = "tcp";
      #     sourcePort  = 80;
      #     destination = my-addresses.http-reverse-proxy.ip4;
      #   }
      #   {# forwards TCP ports 443 of host to microvm domain
      #     proto       = "tcp";
      #     sourcePort  = 443;
      #     destination = my-addresses.https-reverse-proxy.ip4;
      #   }
      # ];
    };
  };
}
