{
  # osConfig stays out of the formals: a declared module arg ignores its default and breaks HM standalone
  flake.aspects.devops.homeManager = { config, lib, ... }@args: with lib; let
    certs = [
      "server-ca.crt"
      "client-admin-persistent.crt"
      "client-admin-persistent.key"
    ];

    # clan returns /no-such-path for a generator declared but not yet generated, sops then takes over
    cert-path = name:
      let
        clan-path = args.osConfig.clan.core.vars.generators.kubernetes-pki.files.${name}.path or null;
        sops-path = config.sops.secrets."kube/${name}".path or null;
      in
        if clan-path != null && clan-path != "/no-such-path" then clan-path else sops-path;

    resolved = all (name: cert-path name != null) certs;
  in {
    config = mkMerge [
      ## no certificate anywhere, the kubeconfig of the local node is the only thing left to point at
      (mkIf (config._.kube && !resolved) {
        home.activation.k3s_config = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          mkdir -p "$HOME/.config/k3s"

          if [ -e /etc/rancher/k3s/k3s.yaml ] && [ ! -L ${config._.dot_config}/k3s/k3s.yaml ]; then
            ln -s /etc/rancher/k3s/k3s.yaml ${config._.dot_config}/k3s/k3s.yaml
          fi
        '';
      })
      (mkIf (config._.kube && resolved) {
        xdg.configFile."k3s/k3s.yaml".text = ''
          apiVersion: v1
          clusters:
          - cluster:
              certificate-authority: ${cert-path "server-ca.crt"}
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
              client-certificate: ${cert-path "client-admin-persistent.crt"}
              client-key: ${cert-path "client-admin-persistent.key"}
        '';
      })
      {
        home.sessionVariables.KUBECONFIG = "${config._.dot_config}/k3s/k3s.yaml";
      }
    ];
  };
}
