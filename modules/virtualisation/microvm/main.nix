{ inputs, self, ... }:{
  flake-file.inputs.microvm = {
    url = "github:astro/microvm.nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.microvm.nixos = { config, lib, ... }:{
    imports = [ inputs.microvm.nixosModules.host ];

    config = lib.mkIf config._.microvm.enable {
      nix.settings = {
        substituters         = [ "https://microvm.cachix.org" ];
        trusted-substituters = [ "https://microvm.cachix.org" ];
        trusted-public-keys  = [ "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys=" ];
      };

      microvm = {
        vms = lib.mapAttrs (name: vm:
          vm // {
            config = {
              imports = (vm.config.imports or [])
                ++ [ (removeAttrs (vm.config or {}) [ "imports" ]) self.modules.generic.options ]
                ++ lib.optional (self.modules.nixos ? ${name}) self.modules.nixos.${name};
            };
          }
        ) config._.microvm.vms;
        stateDir = "/var/lib/microvms";

        host = {
          enable           = true;
          startupTimeout   = 150;
          useNotifySockets = false;
        };

        autostart = [];
      };
    };
  };
}
