{ inputs, ... }:{
  flake-file = {
    inputs = {
      nixpkgs.url       = "github:nixos/nixpkgs/nixos-unstable";
      # nixpkgs.url     = "github:nixos/nixpkgs/nixpkgs-unstable";  ?
      flake-file.url    = "github:vic/flake-file";
      import-tree.url   = "github:vic/import-tree";
      flake-parts = {
        url = "github:hercules-ci/flake-parts";
        inputs.nixpkgs-lib.follows = "nixpkgs";
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
          inputs.flake-aspects.flakeModule
          inputs.hosts.flakeModules.default
          (inputs.import-tree [ 
            ./modules 
            ./options 
            ./aspects
          ])
        ];
      }
    '';
  };

  imports = [ inputs.flake-file.flakeModules.default ];

  systems = [ "x86_64-linux" ];
}
