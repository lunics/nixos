{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    all-network.includes = with aspects; [
      network
      network-manager
      firewall
      wifi
      bluetooth
      dns
    ];
  };
}
