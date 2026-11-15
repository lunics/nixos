{
  flake.aspects.k3s.nixos = { config, lib, pkgs, ... }: with lib; let
    ## installed before the first start, k3s then issues every leaf certificate from these cas
    certs = {
      "root-ca.crt"                 = "0644";
      "intermediate-ca.key"         = "0600";
      "intermediate-ca.crt"         = "0644";
      "server-ca.key"               = "0600";
      "server-ca.crt"               = "0644";
      "client-ca.key"               = "0600";
      "client-ca.crt"               = "0644";
      "client-admin-persistent.key" = "0600";
      "client-admin-persistent.crt" = "0644";
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
            mkdir -p ${tls-dir}

            ${concatStringsSep "\n" (mapAttrsToList
              (name: mode: "install -m ${mode} ${cert-path name} ${tls-dir}/${name}") certs)}
          '';
        };
      })
    ]);
  };
}
