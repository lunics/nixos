{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    microvm.includes = with aspects; [
      networkd
      # nat
      # firewall
    ];
  };
}
