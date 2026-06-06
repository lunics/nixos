{
  flake.aspects.k3s.nixos = { config, options, lib, ... }: with lib; let
    tls-dir = "/var/lib/rancher/k3s/server/tls";
    certs = [
      "server-ca.crt"
      "server-ca.key"
      "client-ca.crt"
      "client-ca.key"
      "request-header-ca.crt"
      "request-header-ca.key"
    ];
    sops-certs = (options ? sops) && (all (target: config.sops.secrets ? "kube/${target}") certs);
  in {
    config = mkIf (config._.k3s.enable && sops-certs) {
      systemd.tmpfiles.rules =
        [ "d ${tls-dir} 0700 root root - -" ]
        ++ map
          (target: "L+ ${tls-dir}/${target} - - - - ${config.sops.secrets."/kube/${target}".path}")
          certs;
    };
  };
}
