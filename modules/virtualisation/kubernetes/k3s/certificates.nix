{
  flake.aspects.k3s.nixos = { config, lib, pkgs, ... }: with lib; let
    ## installed before the first start, k3s then issues every leaf certificate from these cas
    ## any ca left out would be regenerated self-signed by k3s, outside the chain of the kubernetes-pki generator
    certs = {
      "root-ca.crt"                 = { mode = "0644"; dest = "root-ca.crt"; };
      "intermediate-ca.crt"         = { mode = "0644"; dest = "intermediate-ca.crt"; };
      "server-ca.key"               = { mode = "0600"; dest = "server-ca.key"; };
      "server-ca.crt"               = { mode = "0644"; dest = "server-ca.crt"; };
      "client-ca.key"               = { mode = "0600"; dest = "client-ca.key"; };
      "client-ca.crt"               = { mode = "0644"; dest = "client-ca.crt"; };
      "request-header-ca.key"       = { mode = "0600"; dest = "request-header-ca.key"; };
      "request-header-ca.crt"       = { mode = "0644"; dest = "request-header-ca.crt"; };
      "etcd-server-ca.key"          = { mode = "0600"; dest = "etcd/server-ca.key"; };
      "etcd-server-ca.crt"          = { mode = "0644"; dest = "etcd/server-ca.crt"; };
      "etcd-peer-ca.key"            = { mode = "0600"; dest = "etcd/peer-ca.key"; };
      "etcd-peer-ca.crt"            = { mode = "0644"; dest = "etcd/peer-ca.crt"; };
      "service.key"                 = { mode = "0600"; dest = "service.key"; };
      "client-admin-persistent.key" = { mode = "0600"; dest = "client-admin-persistent.key"; };
      "client-admin-persistent.crt" = { mode = "0644"; dest = "client-admin-persistent.crt"; };
    };

    # clan returns /no-such-path for a generator declared but not yet generated, sops then takes over
    cert-path = name:
      let
        clan-path = config.clan.core.vars.generators.kube-pki.files.${name}.path or null;
        sops-path = config.sops.secrets."kube/${name}".path or null;
      in
        if clan-path != null && clan-path != "/no-such-path" then clan-path else sops-path;

    missing = filter (name: cert-path name == null) (attrNames certs);

    tls-dir = "${config._.k3s.data-dir}/server/tls";
  in {
    config = mkIf (config._.k3s.enable) (mkMerge [
      {
        assertions = [{
          assertion = missing == [];
          message   = "k3s: missing certificates ${concatStringsSep " " missing}, neither the clan vars generator kube-pki nor the sops secrets kube/*";
        }];
      }

      (mkIf (missing == []) {
        systemd.services.k3s = {
          path = with pkgs; [ openssl bash coreutils ];
          preStart = ''
            mkdir -p ${tls-dir}/etcd

            ${concatStringsSep "\n" (mapAttrsToList
              (name: cert: "install -m ${cert.mode} ${cert-path name} ${tls-dir}/${cert.dest}") certs)}
          '';
        };
      })
    ]);
  };
}
