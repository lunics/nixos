{ self, ... }:{
  flake.aspects = { aspects, ... }:{
    raspberry-pi.includes = with aspects; [
      options
      disk
      nix
    ];
  };
}
