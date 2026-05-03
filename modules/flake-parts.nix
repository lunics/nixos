{ inputs, lib, self, ... }:{
  imports = [
    inputs.flake-parts.flakeModules.modules
  ];

  # helper functions for creating system / home-manager configurations
  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  config.systems = [
    "x86_64-linux"
  ];

  config.flake.lib = {
    mk_nixos = system: name: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          self.modules.generic.myoptions
          self.modules.nixos.${name}
          { nixpkgs.hostPlatform = lib.mkDefault system; }
        ];
      };
    };

    mk_darwin = system: name: {
      ${name} = inputs.nix-darwin.lib.darwinSystem {
        modules = [
          self.modules.generic.myoptions
          self.modules.darwin.${name}
          { nixpkgs.hostPlatform = lib.mkDefault system; }
        ];
      };
    };

    # nixos + home-manager as submodule
    mk_nixos-hm = system: name: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          self.modules.generic.myoptions
          self.modules.nixos.${name}
          inputs.home-manager.nixosModules.home-manager
          {
            nixpkgs.hostPlatform = lib.mkDefault system;
            home-manager.sharedModules = [ self.modules.generic.myoptions ];
          }
        ];
      };
    };

    mk_home-manager = system: name: {
      ${name} = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        modules = [
          self.modules.generic.myoptions
          self.modules.homeManager.${name}
          {
            home.username = name;
            home.homeDirectory = "/home/${name}";
          }
        ];
      };
    };
  };
}
