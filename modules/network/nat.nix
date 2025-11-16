{
  networking.nat = {
    enable             = true;
    externalInterface  = "wlan0";         # interface connected to the router
    internalInterfaces = [ "enp0s31f6" ]; # interface connected to the machine B
    enableIPv6         = false;           # whether to enable ipv6 nat
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
}
