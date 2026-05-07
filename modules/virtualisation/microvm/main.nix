{ inputs, ... }:{
  flake.aspects.virtualisation.nixos = { ... }:{
    imports = [ inputs.microvm.nixosModules.host ];
  };
}
