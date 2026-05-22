{ inputs, ... }:{
  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.secrets = {
    nixos = { config, ... }:{
      imports = [ inputs.sops-nix.nixosModules.sops ];
      users.groups.sops.name = config._.sops-group;
    };
    homeManager.imports = [ inputs.sops-nix.homeManagerModules.sops ];
  };
}
