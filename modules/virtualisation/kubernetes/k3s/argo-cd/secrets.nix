{
  flake.aspects.k3s.nixos = { config, lib, pkgs, ... }: with lib; let
    # clan returns /no-such-path for a generator declared but not yet generated, sops then takes over
    resolve = gen: file: sops-name:
      let
        clan-path = config.clan.core.vars.generators.${gen}.files.${file}.path or null;
        sops-path = config.sops.secrets.${sops-name}.path or null;
      in
        if clan-path != null && clan-path != "/no-such-path" then clan-path else sops-path;

    admin-password = resolve "argo-cd-admin-password" "password-hash" "argo-cd/admin-password";
    tls-key        = resolve "argo-cd-tls"            "tls.key"       "kube/tls.key";
    tls-crt        = resolve "argo-cd-tls"            "tls.crt"       "kube/tls.crt";

    missing = optional (admin-password == null) "the admin password"
           ++ optional (tls-key == null)        "tls.key"
           ++ optional (tls-crt == null)        "tls.crt";
  in {
    config = mkIf (config._.k3s.enable) (mkMerge [
      {
        assertions = [{
          assertion = missing == [];
          message   = "argo-cd: missing ${concatStringsSep " " missing} to complete the Helm Chart installation";
        }];
      }

      (mkIf (missing == []) {
        systemd.services.argo-cd-secrets = {
          description = "Provision Argo CD certificate and admin password";
          wantedBy    = [ "multi-user.target" ];
          after       = [ "argo-cd-helm-chart.service" ];
          requires    = [ "argo-cd-helm-chart.service" ];
          path        = with pkgs; [ coreutils ];
          serviceConfig = {
            Type            = "oneshot";
            RemainAfterExit = true;
          };
          script = ''
            until ${config._.k3s.kubectl} get namespace argo-cd >/dev/null 2>&1; do
              sleep 1
            done

            ${config._.k3s.kubectl} apply -f - << EOF
            apiVersion: v1
            kind: Secret
            metadata:
              name: argocd-secret
              namespace: argo-cd
            type: Opaque
            stringData:
              admin.password: "$(cat ${admin-password})"
              admin.passwordMtime: "2026-01-01T00:00:00Z"
            data:
              tls.key: $(base64 -w0 ${tls-key})
              tls.crt: $(base64 -w0 ${tls-crt})
            EOF
          '';
        };
      })
    ]);
  };
}
