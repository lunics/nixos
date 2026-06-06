{
  flake.aspects.devops.homeManager = { config, lib, options, ... }: with lib; let
    certs = [
      "certificate-authority-data"
      "client-certificate-data"
      "client-key-data"
    ];
    sops-certs = (options ? sops) && (all (target: config.sops.secrets ? "kube/k3s.yaml/${target}") certs);
  in {
    config = mkMerge [
      (mkIf (config._.kube && !sops-certs) {
        home.activation.k3s_config = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          mkdir -p "$HOME/.config/k3s"

          if [ -e /etc/rancher/k3s/k3s.yaml ] && [ ! -L ${config._.dot_config}/k3s/k3s.yaml ]; then
            ln -s /etc/rancher/k3s/k3s.yaml ${config._.dot_config}/k3s/k3s.yaml
          fi
        '';
      })
      (mkIf (config._.kube && sops-certs) {
        xdg.configFile."k3s/k3s.yaml".text = ''
          apiVersion: v1
          clusters:
          - cluster:
              certificate-authority-data: ${config.sops.secrets."/kube/k3s.yaml/certificate-authority-data".path}
              server: https://127.0.0.1:6443
            name: default
          contexts:
          - context:
              cluster: default
              user: default
            name: default
          current-context: default
          kind: Config
          users:
          - name: default
            user:
              client-certificate-data: ${config.sops.secrets."/kube/k3s.yaml/client-certificate-data".path}
              client-key-data: ${config.sops.secrets."/kube/k3s.yaml/client-key-data".path}
        '';
      })
      {
        home.sessionVariables.KUBECONFIG = "${config._.dot_config}/k3s/k3s.yaml";
      }
    ];
  };
}
