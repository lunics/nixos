{ inputs, ... }:{
  flake-file.inputs.multiverse.url = "github:fzakaria/nixpkgs-multiverse";

  flake.aspects.nix = {
    nixos = {
      imports = [ inputs.multiverse.nixosModules.default ];

      multiverse.enable = true;    # without it the pins resolve but are never installed
    };

    homeManager = {
      imports = [ inputs.multiverse.homeManagerModules.default ];

      multiverse.enable = true;
    };
  };
}
