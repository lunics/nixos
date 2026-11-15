{ inputs, self, ... }:{
  flake-file.inputs.microvm = {
    url = "github:astro/microvm.nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.microvm.nixos = { config, lib, ... }:
  let
    # clan returns /no-such-path for a generator declared but not yet generated, sops then takes over
    secret-path = name:
      let
        clan-path = config.clan.core.vars.generators.${name}.files.${name}.path or null;
        sops-path = config.sops.secrets.${name}.path or null;
      in 
        if clan-path != null && clan-path != "/no-such-path" then clan-path else sops-path;

    with-secrets = lib.filterAttrs (_: vm: vm.secrets != []) config._.microvm.vms;
    unresolved   = lib.unique (lib.concatMap
      (vm: lib.filter (name: secret-path name == null) vm.secrets)
      (lib.attrValues with-secrets));
  in {
    imports = [ inputs.microvm.nixosModules.host ];

    config = lib.mkIf config._.microvm.enable (lib.mkMerge [
      {
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
        }) config._.microvm.vms
        ++ [{
          assertion = unresolved == [];
          message   = "microvm: no credentials for ${lib.concatStringsSep " " unresolved}, neither a clan vars generator of that name nor a host sops secret";
        }];

        _.persistent-system.dirs = [
          config.microvm.stateDir    # per vm volumes and the generated vm state
        ];
      }

      # systemd loads the secret files as root, so the host files can stay root only
      (lib.mkIf (unresolved == []) {
        systemd.services = lib.mapAttrs' (name: vm: lib.nameValuePair "microvm@${name}" {
          overrideStrategy             = "asDropin";
          serviceConfig.LoadCredential = map (secret: "${secret}:${secret-path secret}") vm.secrets;
        }) with-secrets;
      })
    ]);
  };
}
