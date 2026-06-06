{
  flake.aspects.k3s.nixos = { config, options, lib, pkgs, ... }: with lib; let
    tls-dir = "/var/lib/rancher/k3s/server/tls";

    certs = [
      "root-ca.pem"
      "intermediate-ca.key"
      "intermediate-ca.pem"
    ];

    sops-certs = (options ? sops) && (all (target: config.sops.secrets ? "kube/${target}") certs);

    generate-ca-certs = pkgs.fetchurl {
      url    = "https://raw.githubusercontent.com/k3s-io/k3s/v1.31.0+k3s1/contrib/util/generate-custom-ca-certs.sh";
      sha256 = "sha256-11s8jna9k02s31kid84hs8y7zkxvadvlihqxv3dmzq0yi6awpjqd";
    };
  in {
    config = mkIf (config._.k3s.enable && sops-certs) {
      systemd.services.k3s = {
        path = with pkgs; [ openssl bash coreutils ];
        preStart = ''
          mkdir -p /var/lib/rancher/k3s/server/tls

          install -m 0644 ${config.sops.secrets."kube/root-ca.pem".path}         ${tls-dir}/root-ca.pem
          install -m 0644 ${config.sops.secrets."kube/intermediate-ca.pem".path} ${tls-dir}/intermediate-ca.pem
          install -m 0600 ${config.sops.secrets."kube/intermediate-ca.key".path} ${tls-dir}/intermediate-ca.key

          if [ ! -f ${tls-dir}/server-ca.crt ]; then
            bash ${generate-ca-certs}
          fi
        '';
      };
    };
  };
}
