{ inputs, ... }:{
  flake-file.inputs.microvm = {
    url = "github:astro/microvm.nix";
    inputs.nixpkgs.follows = "nixpkgs"; 
  };

  flake.aspects.virtualisation.nixos = { ... }:{
    imports = [ inputs.microvm.nixosModules.host ];
  };
}
