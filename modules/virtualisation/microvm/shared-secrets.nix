{
  flake.aspects.microvm.nixos = { config, lib, ... }: with lib;
  let
    mkVmSecretsService = vm:    # creates a ${vm}-secrets.service for each microvm
      let
        # vmSecrets is an attrset: { "microvms/myvm/..." = { path = "/run/secrets/microvms/myvm/..."; }; ... }
        vmSecrets = filterAttrs
          (name: _: hasPrefix "microvms/${vm}/" name) config.sops.secrets;
      in {
        # mapAttrsToList iterates over vmSecrets to produce a list of: 
        #   [ "install -m 0400 /run/secrets/microvms/myvm/mysecret /var/lib/microvms/myvm/secrets/mysecret" ]
        "${vm}-secrets" = {
          description = "Shared sops secrets for MicroVM ${vm}";
          wantedBy = ["microvm@${vm}.service"];
          before   = ["microvm@${vm}.service"];
          serviceConfig.Type = "oneshot";
          script = ''
            ${concatStringsSep "\n" (mapAttrsToList (name: secret: let
              no-prefix-path = removePrefix "microvms/${vm}/" name;
              dest-path      = "/var/lib/microvms/${vm}/secrets/${no-prefix-path}";
            in ''
              install -D -m 0400 ${secret.path} ${dest-path}
            '') vmSecrets)}
          '';
        };
      };
  in {
    config = mkIf config._.microvm.sops {
      systemd.services = mkMerge (map mkVmSecretsService (attrNames config.microvm.vms));
    };
  };
}
