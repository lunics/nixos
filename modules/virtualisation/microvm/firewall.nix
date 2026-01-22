{ config, lib, ... }:{
  config = lib.mkIf config._.microvm.enable {
    networking.firewall.allowedUDPPorts = [  # Allow inbound traffic for the DHCP server (for advanced network setup for microvms)
      67 
      22  # for internal SSH microvm ?
    ];
  };
}
