{ inputs, ... }:{
  flake-file.inputs.multiverse.url = "github:fzakaria/nixpkgs-multiverse";

  flake.aspects.nix = {
    nixos = {
      imports = [ inputs.multiverse.nixosModules.default ];
    };

    homeManager = {
      imports = [ inputs.multiverse.homeManagerModules.default ];
    };
  };
}
