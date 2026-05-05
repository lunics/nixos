{
  flake.modules.nixos.firewall = {
    networking.firewall = {
      enable = true;

      # allowedTCPPorts = [];

      allowedUDPPorts = [
        # 53317     # localsend
      ];
    };
  };
}
