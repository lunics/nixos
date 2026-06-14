{
  flake.aspects.k3s.nixos = { config, options, lib, pkgs, ... }: with lib; let
    secrets = [
      "tls.crt"
      "tls.key"
      "admin-password"
    ];
    has-secrets = (options ? sops) && (all (name: config.sops.secrets ? "argo-cd/${name}") secrets);
    kubectl = "${pkgs.kubectl}/bin/kubectl --kubeconfig=/etc/rancher/k3s/k3s.yaml";
  in {
    config = mkIf (config._.k3s.enable && has-secrets) {
      systemd.services.argo-cd-secrets = {
        description = "Provision Argo CD certificate and admin password";
        wantedBy    = [ "multi-user.target" ];
        after       = [ "k3s.service" ];
        requires    = [ "k3s.service" ];
        path        = with pkgs; [ coreutils ];
        serviceConfig = {
          Type            = "oneshot";
          RemainAfterExit = true;
        };
        script = ''
          until ${kubectl} get --raw=/readyz >/dev/null 2>&1; do
            sleep 1
          done

          ${kubectl} create namespace argo-cd --dry-run=client -o yaml | ${kubectl} apply -f -

          ${kubectl} apply -f - <<EOF
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
            tls.key: $(base64 -w0 ${config.sops.secrets."kube/cluster-cert.key".path})
            tls.crt: $(base64 -w0 ${config.sops.secrets."kube/cluster-cert.crt".path})
          EOF
        '';
      };
    };
  };
}
