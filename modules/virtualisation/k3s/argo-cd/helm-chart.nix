{
  flake.aspects.k3s.nixos = { config, lib, pkgs, ... }:{
    config = lib.mkIf config._.k3s.enable {
      systemd.services.argo-cd-helm-chart = {
        description = "Provision Argo CD Helm Chart";
        wantedBy    = [ "multi-user.target" ];
        after       = [ "k3s.service" ];
        requires    = [ "k3s.service" ];
        environment.KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
        serviceConfig = {
          Type            = "oneshot";
          RemainAfterExit = true;
        };
        script = ''
          # cat > /var/lib/rancher/k3s/server/manifests/argo-cd-helm-chart.yaml << EOF

          ${pkgs.kubectl}/bin/kubectl apply -f - << EOF
          apiVersion: helm.cattle.io/v1
          kind: HelmChart
          metadata:
            name: argo-cd
            namespace: kube-system
          spec:
            chart: argo-cd
            repo: https://argoproj.github.io/argo-helm
            version: 9.5.20
            targetNamespace: argo-cd
            createNamespace: true
            valuesContent: |
              fullnameOverride: argo-cd
              configs:
                secret:
                  createSecret: false     # managed in ./secrets.nix
          EOF
        '';
      };
    };
  };
}
