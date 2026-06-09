{
  flake.aspects.k3s.nixos = { config, lib, ... }: let
    kubectl = "${pkgs.kubectl}/bin/kubectl --kubeconfig=/etc/rancher/k3s/k3s.yaml";
  in {
    config = lib.mkIf config._.k3s.enable {
      systemd.services.argo-cd-root-app = {
        description = "Provision Argo CD root application";
        wantedBy    = [ "multi-user.target" ];
        after       = [ "argo-cd-git-repo.service" ];
        requires    = [ "argo-cd-git-repo.service" ];
        serviceConfig = {
          Type            = "oneshot";
          RemainAfterExit = true;
        };
        script = ''
          ${kubectl} apply -f - <<EOF
          apiVersion: argoproj.io/v1alpha1
          kind: Application
          metadata:
            name:      root-app
            namespace: argo-cd
          spec:
            source:
              repoURL:        git@${config._.argo-cd-repo-url}
              targetRevision: HEAD
              path:           root-app
              directory:
                recurse: true
            destination:
              server:    https://kubernetes.default.svc
              namespace: argo-cd
            project: default
            syncPolicy:
              automated:
                prune:    true
                selfHeal: true
          EOF
        '';
      };
    };
  };
}
