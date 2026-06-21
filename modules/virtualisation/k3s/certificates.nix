{
  flake.aspects.k3s.nixos = { config, options, lib, pkgs, ... }: with lib; let
    secrets = [
      "root-ca.crt"
      "intermediate-ca.key"
      "intermediate-ca.crt"
      "server-ca.key"
      "server-ca.crt"
      "client-admin.key"
      "client-admin.crt"
    ];
    has-secrets = (options ? sops) && (all (cert: config.sops.secrets ? "kube/${cert}") secrets);

    tls-dir = "/var/lib/rancher/k3s/server/tls";

    generate-ca-certs = pkgs.fetchurl {
      url    = "https://raw.githubusercontent.com/k3s-io/k3s/v1.31.0+k3s1/contrib/util/generate-custom-ca-certs.sh";
      sha256 = "11s8jna9k02s31kid84hs8y7zkxvadvlihqxv3dmzq0yi6awpjqd";
    };
  in {
    config = mkIf (config._.k3s.enable) {
      assertions = [{
        assertion = has-secrets;
        message   = "k3s: missing certificate secrets to install custom CA";
      }];

      systemd.services.k3s = {
        path = with pkgs; [ openssl bash coreutils ];
        preStart = ''
          mkdir -p ${tls-dir}

          install -m 0644 ${config.sops.secrets."kube/root-ca.crt".path}         ${tls-dir}/root-ca.crt
          install -m 0600 ${config.sops.secrets."kube/intermediate-ca.key".path} ${tls-dir}/intermediate-ca.key
          install -m 0644 ${config.sops.secrets."kube/intermediate-ca.crt".path} ${tls-dir}/intermediate-ca.crt
          install -m 0600 ${config.sops.secrets."kube/server-ca.key".path}       ${tls-dir}/server-ca.key
          install -m 0644 ${config.sops.secrets."kube/server-ca.crt".path}       ${tls-dir}/server-ca.crt
          install -m 0600 ${config.sops.secrets."kube/client-admin.key".path}    ${tls-dir}/client-admin.key
          install -m 0644 ${config.sops.secrets."kube/client-admin.crt".path}    ${tls-dir}/client-admin.crt

          # bash ${generate-ca-certs}
        '';
      };
    };
  };
}
