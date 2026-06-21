{
  flake.aspects.devops.homeManager = { config, lib, options, ... }: with lib; let
    certs = [
      "server-ca.crt"
      "client-admin-persistent.crt"
      "client-admin-persistent.key"
    ];
    sops-certs = (options ? sops) && (all (target: config.sops.secrets ? "kube/${target}") certs);
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
              certificate-authority: ${config.sops.secrets."kube/server-ca.crt".path}
              server: https://${config._.k3s.master-node-ip}:6443
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
              client-certificate: ${config.sops.secrets."kube/client-admin-persistent.crt".path}
              client-key: ${config.sops.secrets."kube/client-admin-persistent.key".path}
        '';
      })
      {
        home.sessionVariables.KUBECONFIG = "${config._.dot_config}/k3s/k3s.yaml";
      }
    ];
  };
}
