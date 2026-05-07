{
  flake.aspects.nat.nixos = {
    networking.nat = {
      enable             = true;
      enableIPv6         = true;            # whether to enable ipv6 nat
      externalInterface  = "wlan0";         # interface connected to the router
      internalInterfaces = [ "microvm" ];   # interface connected to the machine B
      internalIPs        = [];              # list of internal ip address ranges (cidr notation)
      internalIPv6s      = [];              # list of internal ipv6 address ranges
      externalInterface  = null;            # external network interface for nat
      externalIP         = null;            # external ip address (auto-detected if null)
      externalIPv6       = null;            # external ipv6 address
      forwardPorts       = [];              # list of port forwarding rules
      dmzHost            = null;            # internal ip address to forward all traffic to
      extraCommands      = "";              # additional iptables commands to run
      extraStopCommands  = "";              # additional commands to run when stopping nat
      forwardPorts.443 = {
        destination = "10.0.0.1:80";
        loopbackIPs = [ "55.1.2.3" ];
        proto = "tcp";
        sourcePort = 443;       # source port of the external interface
      };
    };
  };
}
