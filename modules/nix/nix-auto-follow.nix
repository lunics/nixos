{ inputs, ... }:{
  flake-file.inputs = {
    nix-auto-follow = {
      url = "github:fzakaria/nix-auto-follow";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.aspects.nix.homeManager = { pkgs, ... }:{
    home.packages = [
      inputs.nix-auto-follow.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
