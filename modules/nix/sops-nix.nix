{ inputs, ... }:{
  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.secrets = {
    nixos.imports       = [ inputs.sops-nix.nixosModules.sops ];
    homeManager.imports = [ inputs.sops-nix.homeManagerModules.sops ];
  };
}
