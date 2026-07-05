{ inputs, ... }:{
  flake-file.inputs = {
    nixos-anywhere = {
      url = "github:nix-community/nixos-anywhere";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        disko.follows   = "disko";
      };
    };
  };

  flake.aspects.nix.homeManager = { pkgs, ... }:{
    home.packages = [
      inputs.nixos-anywhere.packages.${pkgs.system}.default
    ];
  };
}
