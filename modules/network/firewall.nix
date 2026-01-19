{
  networking.firewall = {
    enable = true;

    # allowedTCPPorts = [];

    allowedUDPPorts = [
      67          # Allow inbound traffic for the DHCP server (for advanced network setup for microvms)
      # 53317     # localsend
    ];
  };
}
