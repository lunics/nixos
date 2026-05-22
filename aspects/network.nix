{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    network.includes = with aspects; [
      network-manager
      firewall
      wifi
      bluetooth
      vpn
      dns
    ];
  };
}
