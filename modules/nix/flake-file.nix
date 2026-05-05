{ inputs, ... }:{
  imports = [ inputs.flake-file.flakeModules.default ];

  flake-file = {
    inputs = {
      nixpkgs.url       = "github:nixos/nixpkgs/nixos-unstable";
      # nixpkgs.url     = "github:nixos/nixpkgs/nixpkgs-unstable";  ?
      flake-file.url    = "github:vic/flake-file";
      import-tree.url   = "github:vic/import-tree";
      impermanence.url  = "github:nix-community/impermanence";
      flake-aspects.url = "github:vic/flake-aspects";
      flake-parts = {
        url = "github:hercules-ci/flake-parts";
        inputs.nixpkgs-lib.follows = "nixpkgs";
      };
      disko = {
        url = "github:nix-community/disko";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      hosts = {
        url = "git+file:./hosts";
        inputs = {
          nixpkgs.follows = "nixpkgs";
          flake-parts.follows = "flake-parts";
          import-tree.follows = "import-tree";
        };
      };
    };

    outputs = ''
      inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
        imports = [
          (inputs.import-tree [ ./modules ./options ])
          inputs.hosts.flakeModules.default
        ];
      }
    '';
  };

  # systems = inputs.nixpkgs.lib.systems.flakeExposed; ?
  systems = [ "x86_64-linux" ];
}
