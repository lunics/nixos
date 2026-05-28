{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    microvm.includes = with aspects; [
      nat
      networkd
      # firewall
    ];
  };
}
