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
          self.lib.mvms-template { inherit name vm; host = config; }
        ) config._.microvm.vms;

        stateDir = "/var/lib/microvms";

        host = {
          enable           = true;
          startupTimeout   = 150;
          useNotifySockets = false;
        };

        autostart = [];
      };

      assertions = lib.mapAttrsToList (name: vm: {
        assertion = vm.secrets == [] || vm.hypervisor == "qemu";
        message   = "microvm ${name}: secrets need the qemu hypervisor, the only one supporting credentialFiles";
      }) config._.microvm.vms;

      # systemd loads the sops secrets as root, so the host files can stay root only
      systemd.services = lib.mapAttrs' (name: vm: lib.nameValuePair "microvm@${name}" {
        overrideStrategy             = "asDropin";
        serviceConfig.LoadCredential = map (secret: "${secret}:/run/secrets/${secret}") vm.secrets;
      }) (lib.filterAttrs (_: vm: vm.secrets != []) config._.microvm.vms);

      _.persistent-system.dirs = [
        config.microvm.stateDir    # per vm volumes and the generated vm state
      ];
    };
  };
}
