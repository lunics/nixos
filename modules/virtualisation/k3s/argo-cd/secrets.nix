{
  flake.aspects.k3s.nixos = { config, options, lib, pkgs, ... }: with lib; let
    has-pwd = (options ? sops) && (config.sops.secrets ? "argo-cd/admin-password");
    kubectl = "${pkgs.kubectl}/bin/kubectl --kubeconfig=/etc/rancher/k3s/k3s.yaml";
  in {
    config = mkIf (config._.k3s.enable && has-pwd) {
      systemd.services.argo-cd-secrets = {
        description = "Provision argocd-secret from sops";
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

          if ! ${kubectl} get secret argocd-secret -n argo-cd >/dev/null 2>&1; then
            ${kubectl} create namespace argo-cd   # required, happens earlier than the argo-cd chart deployment

            ${kubectl} create secret generic argocd-secret \
              --namespace argo-cd \
              --from-literal=admin.password="$(cat ${config.sops.secrets."argo-cd/admin-password".path})" \
              --from-literal=admin.passwordMtime="2026-01-01T00:00:00Z"
          fi
        '';
      };
    };
  };
}
