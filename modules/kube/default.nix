{ config, lib, ... }:{
  imports = [
    ./packages.nix
    ./helm.nix
    ./k9s
    ./shell_aliases.nix
  ];

  config = lib.mkIf config._.kube {
    home = {
      activation.k3s_config = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        mkdir -p "$HOME/.config/k3s"

        if [ -e /etc/rancher/k3s/k3s.yaml ] && [ ! -L ${config._.dot_config}/k3s/k3s.yaml ]; then
          ln -s /etc/rancher/k3s/k3s.yaml ${config._.dot_config}/k3s/k3s.yaml
        fi
      '';

      sessionVariables.KUBECONFIG = "${config._.dot_config}/k3s/k3s.yaml";
    };
  };
}
