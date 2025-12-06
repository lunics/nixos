{ config, lib, ... }:{
  imports = [
    ./pkg.nix
    ./helm.nix
    ./k9s
    ./shell_aliases.nix
  ];

  config = lib.mkIf config._.kube {
    home.sessionVariables.KUBECONFIG = "${config._.dot_config}/k3s/k3s.yaml";

    home.activation.k3s_config = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ln -s /etc/rancher/k3s/k3s.yaml ${config._.dot_config}/k3s/k3s.yaml &> /dev/null || true
    '';
  };
}
