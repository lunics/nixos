{ self, ... }:{
  flake.aspects.network.nixos = { config, lib, ... }:{
    imports = with self.modules.nixos; [
      network_manager
      firewall
      wifi
      bluetooth
      vpn
      dns
    ];

    networking = {
      hostName = config._.hostName;

      useDHCP = lib.mkDefault true;

      # interfaces.wlp3s0.useDHCP    = lib.mkDefault true;
    };

    # network diagnostic tool that combines ping and traceroute into one program
    programs.mtr.enable = true;
  };
}
