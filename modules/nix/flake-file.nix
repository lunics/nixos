{ inputs, ... }:{
  flake-file = {
    inputs = {
      nixpkgs.url     = "github:nixos/nixpkgs/nixpkgs-unstable";
      flake-file.url  = "github:vic/flake-file";
      import-tree.url = "github:vic/import-tree";
      flake-compat.url = "github:NixOS/flake-compat";
      flake-parts = {
        url = "github:hercules-ci/flake-parts";
        inputs.nixpkgs-lib.follows = "nixpkgs";
      };
      # no direct use: top-level input so omniflake and yt-x share a single flake-utils (auto-follow)
      flake-utils = {
        url = "github:numtide/flake-utils";
        inputs.systems.follows = "systems";
      };
    };

    outputs = ''
      inputs:
      let
        tree = inputs.import-tree [
          ./modules
          ./options
          ./aspects
        ];
      in inputs.flake-parts.lib.mkFlake { inherit inputs; } {
        imports = [
          inputs.flake-aspects.flakeModule
          tree
        ];

        flake.flakeModules.default = tree;
      }
    '';
  };

  imports = [ inputs.flake-file.flakeModules.default ];
}
