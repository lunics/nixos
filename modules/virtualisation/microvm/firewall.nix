{
  flake.aspects.virtualisation.nixos = { config, lib, ... }:{
    config = lib.mkIf config._.microvm.enable {
      # networking.firewall.interfaces."microvm-net-2".allowedTCPPorts = [ 22 ];
      # networking.firewall.allowedUDPPorts = [ # Allow inbound traffic for the DHCP server (for advanced network setup for microvms)
      #   # 67
      #   22  # for internal SSH microvm ?
      # ];
    };
  };
}
