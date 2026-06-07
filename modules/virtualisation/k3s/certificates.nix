{
  flake.aspects.k3s.nixos = { config, options, lib, pkgs, ... }: with lib; let
    secrets = [
      "root-ca.crt"
      "intermediate-ca.key"
      "intermediate-ca.crt"
    ];
    has-secrets = (options ? sops) && (all (cert: config.sops.secrets ? "kube/${cert}") secrets);

    tls-dir = "/var/lib/rancher/k3s/server/tls";

    generate-ca-certs = pkgs.fetchurl {
      url    = "https://raw.githubusercontent.com/k3s-io/k3s/v1.31.0+k3s1/contrib/util/generate-custom-ca-certs.sh";
      sha256 = "11s8jna9k02s31kid84hs8y7zkxvadvlihqxv3dmzq0yi6awpjqd";
    };
  in {
    config = mkIf (config._.k3s.enable && has-secrets) {
      systemd.services.k3s = {
        path = with pkgs; [ openssl bash coreutils ];
        preStart = ''
          install -m 0644 ${config.sops.secrets."kube/root-ca.crt".path}         ${tls-dir}/root-ca.crt
          install -m 0600 ${config.sops.secrets."kube/intermediate-ca.key".path} ${tls-dir}/intermediate-ca.key
          install -m 0644 ${config.sops.secrets."kube/intermediate-ca.crt".path} ${tls-dir}/intermediate-ca.crt

          if [ ! -f ${tls-dir}/server-ca.crt ]; then
            bash ${generate-ca-certs}
          fi
        '';
      };
    };
  };
}
