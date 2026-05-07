{
  flake.aspects.firewall.nixos = {
    networking.firewall = {
      enable = true;

      # allowedTCPPorts = [];

      allowedUDPPorts = [
        # 53317     # localsend
      ];
    };
  };
}
