{
  flake.aspects.k3s.nixos = { config, options, lib, pkgs, ... }: with lib; let
    secrets = [
      "kube/tls.crt"
      "kube/tls.key"
      "argo-cd/admin-password"
    ];
    has-secrets = (options ? sops) && (all (name: config.sops.secrets ? ${name}) secrets);
  in {
    config = mkIf (config._.k3s.enable) {
      assertions = [{
        assertion = has-secrets;
        message   = "argo-cd: missing secrets to complete Helm Chart installation";
      }];

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
          until ${pkgs.kubectl}/bin/kubectl get namespace argo-cd >/dev/null 2>&1; do
            sleep 1
          done

          ${pkgs.kubectl}/bin/kubectl apply -f - <<EOF
          apiVersion: v1
          kind: Secret
          metadata:
            name: argocd-secret
            namespace: argo-cd
          type: Opaque
          stringData:
            admin.password: "$(cat ${config.sops.secrets."argo-cd/admin-password".path})"
            admin.passwordMtime: "2026-01-01T00:00:00Z"
          data:
            tls.key: $(base64 -w0 ${config.sops.secrets."kube/tls.key".path})
            tls.crt: $(base64 -w0 ${config.sops.secrets."kube/tls.crt".path})
          EOF
        '';
      };
    };
  };
}
