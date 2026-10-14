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
                ++ [
                  (removeAttrs (vm.config or {}) [ "imports" ])
                  self.modules.generic.options
                  {
                    # guest defaults inherited from the host, each vm can still override them
                    time.timeZone       = lib.mkDefault config.time.timeZone;
                    networking.hostName = lib.mkDefault name;
                    system.stateVersion = lib.mkDefault config.system.nixos.release;
                  }
                ]
                # resolve the aspect itself, modules.nixos skips aspects made only of includes
                ++ lib.optional (self.aspects ? ${name}) (self.aspects.${name}.resolve { class = "nixos"; });
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
