{ inputs, lib, self, ... }:{
  imports = [ inputs.flake-parts.flakeModules.modules ];

  # helper functions for creating system / home-manager configurations
  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  config.systems = [
    "x86_64-linux"
  ];

  config.flake.lib = {
    make_nixos = system: name: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          self.modules.generic.options
          self.modules.nixos.${name}
          {
            nixpkgs.hostPlatform = lib.mkDefault system;
            _.machine-index = lib.mkDefault (
              let last = lib.substring (builtins.stringLength name - 1) 1 name;
              in if builtins.match "[0-9]" last != null then lib.toInt last else 0
            );
          }
        ];
      };
    };

    make_darwin = system: name: {
      ${name} = inputs.nix-darwin.lib.darwinSystem {
        modules = [
          self.modules.generic.options
          self.modules.darwin.${name}
          { nixpkgs.hostPlatform = lib.mkDefault system; }
        ];
      };
    };

    # nixos + home-manager as submodule
    make_nixos-hm = system: name: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          self.modules.generic.options
          self.modules.nixos.${name}
          inputs.home-manager.nixosModules.home-manager
          {
            nixpkgs.hostPlatform = lib.mkDefault system;
            home-manager.sharedModules = [ 
              self.modules.generic.options 
              inputs.sops-nix.homeManagerModules.sops
            ];
          }
        ];
      };
    };

    make_home-manager = system: user-at-host: let
      # required to split username from user@host
      parts    = inputs.nixpkgs.lib.splitString "@" user-at-host;
      username = builtins.elemAt parts 0;
      # host     = builtins.elemAt parts 1;
    in {
      ${user-at-host} = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        modules = [
          self.modules.generic.options
          self.modules.homeManager.${user-at-host}
          {
            home.username = username;
            home.homeDirectory = "/home/${username}";
          }
        ];
      };
    };

    make_raspberry-pi = system: name: {
      ${name} = inputs.nixos-raspberrypi.lib.nixosSystem {
        specialArgs = inputs;
        modules = [
          self.modules.generic.options
          self.modules.nixos-raspberrypi.${name}
          { 
            nixpkgs.hostPlatform = lib.mkDefault system; 
          }
        ];
      };
    };
  };
}
