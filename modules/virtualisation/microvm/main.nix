{ inputs, ... }:{
  flake-file.inputs.microvm = {
    url = "github:astro/microvm.nix";
    inputs.nixpkgs.follows = "nixpkgs"; 
  };

  flake.aspects.microvm.nixos = {
    imports = [ inputs.microvm.nixosModules.host ];

    nix.settings = {
      substituters         = [ "https://microvm.cachix.org" ];
      trusted-substituters = [ "https://microvm.cachix.org" ];
      trusted-public-keys  = [ "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys=" ];
    };
  };
}
