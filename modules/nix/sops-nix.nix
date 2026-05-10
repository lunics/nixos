{ inputs, ... }:{
  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  imports = [ inputs.sops-nix.nixosModules.sops ];
}
