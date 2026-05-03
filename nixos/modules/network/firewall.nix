{
  networking.firewall = {
    enable = true;

    # allowedTCPPorts = [];

    allowedUDPPorts = [
      # 53317     # localsend
    ];
  };
}
