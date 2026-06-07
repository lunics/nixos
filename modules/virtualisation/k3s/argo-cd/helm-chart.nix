{
  flake.aspects.k3s.nixos = { config, lib, ... }:{
    config = lib.mkIf config._.k3s.enable {
      services.k3s.manifests."argo-cd-helm-chart".content = {
        kind = "HelmChart";
        apiVersion = "helm.cattle.io/v1";
        metadata = {
          name = "argo-cd";
          namespace = "kube-system";
        };
        spec = {
          repo = "https://argoproj.github.io/argo-helm";
          chart = "argo-cd";
          version = "9.5.20";
          targetNamespace = "argo-cd";
          createNamespace = true;
          valuesContent = ''
            fullnameOverride: argo-cd
            configs:
              secret:
                createSecret: false     # managed in ./secrets.nix
          '';
        };
      };
    };
  };
}
