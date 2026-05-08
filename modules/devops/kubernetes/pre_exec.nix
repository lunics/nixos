{ config, lib, ... }:{
  config = lib.mkIf config._.kube {
    home = {
      activation.k3s_config = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        mkdir -p "$HOME/.config/k3s"
        ln -s /etc/rancher/k3s/k3s.yaml ${config._.dot_config}/k3s/k3s.yaml &> /dev/null || true
      '';

      sessionVariables.KUBECONFIG = "${config._.dot_config}/k3s/k3s.yaml";
    };
  };
}
