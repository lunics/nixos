{ config, inputs, lib, self, ... }:{
  imports = [ inputs.flake-parts.flakeModules.modules ];

  # helper functions for creating system / home-manager configurations
  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  config.flake.lib =
  let
    # generic options and vars host values, shared by the nixos and home-manager evals;
    # resolved from the aspect, flake.modules.vars would stamp a _class nixos and home-manager refuse
    vars = name: {
      imports = map (class: config.flake.aspects.${name}.resolve { inherit class; }) ["generic" "vars"];
    };
  in {
    inherit vars;

    make_nixos = system: name: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          (vars name)
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

    make_clan_nixos = system: names: lib.genAttrs names (name: {
      imports = [
        (vars name)
        self.modules.nixos.${name}
      ];

      nixpkgs.hostPlatform = lib.mkDefault system;

      clan.core.networking.targetHost = lib.mkDefault "root@${name}";

      _.machine-index = lib.mkDefault (
        let last = lib.substring (builtins.stringLength name - 1) 1 name;
        in if builtins.match "[0-9]" last != null then lib.toInt last else 0
      );
    });

    # clan machines + home-manager as submodule
    make_clan_nixos-hm = system: names: lib.genAttrs names (name: {
      imports = [
        (vars name)
        self.modules.nixos.${name}
        inputs.home-manager.nixosModules.home-manager
      ];

      nixpkgs.hostPlatform = lib.mkDefault system;

      clan.core.networking.targetHost = lib.mkDefault "root@${name}";

      _.machine-index = lib.mkDefault (
        let last = lib.substring (builtins.stringLength name - 1) 1 name;
        in if builtins.match "[0-9]" last != null then lib.toInt last else 0
      );

      # home-manager reuses the system pkgs, the overlays of its aspects are applied here
      nixpkgs.overlays = lib.attrValues self.overlays;

      home-manager = {
        useGlobalPkgs   = true;
        useUserPackages = true;    # packages in /etc/profiles/per-user, outside the ephemeral home
        sharedModules   = [
          (vars name)
          inputs.sops-nix.homeManagerModules.sops
        ];
      };
    });

    make_darwin = system: name: {
      ${name} = inputs.nix-darwin.lib.darwinSystem {
        modules = [
          (vars "options")
          self.modules.darwin.${name}
          { 
            nixpkgs.hostPlatform = lib.mkDefault system; 
          }
        ];
      };
    };

    # nixos + home-manager as submodule
    make_nixos-hm = system: name: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          (vars name)
          self.modules.nixos.${name}
          inputs.home-manager.nixosModules.home-manager
          {
            nixpkgs.hostPlatform = lib.mkDefault system;

            # home-manager reuses the system pkgs, the overlays of its aspects are applied here
            nixpkgs.overlays = lib.attrValues self.overlays;

            home-manager = {
              useGlobalPkgs   = true;
              useUserPackages = true;    # packages in /etc/profiles/per-user, outside the ephemeral home
              sharedModules   = [
                (vars name)
                inputs.sops-nix.homeManagerModules.sops
              ];
            };
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
          (vars "options")
          self.modules.homeManager.${user-at-host}
          {
            home.username = username;
            home.homeDirectory = "/home/${username}";
            nixpkgs.overlays = lib.attrValues self.overlays;
          }
        ];
      };
    };

    make_raspberry-pi = system: name: {
      ${name} = inputs.nixos-raspberrypi.lib.nixosSystem {
        specialArgs = inputs;
        modules = [
          (vars name)
          # flake-parts stamps _class on every other modules class, and nixosSystem rejects it
          self.modules.nixos.${name}
          { 
            nixpkgs.hostPlatform = lib.mkDefault system; 
          }
        ];
      };
    };
  };
}
