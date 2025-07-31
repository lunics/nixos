{ config, ... }:{
  imports = [
    ./pkg.nix
    ./helm.nix
    ./k9s
  ];

  # home.activation.home-dirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   # k3s module
  #   mkdir -p "${config.xdg.configHome}/k3s"
  # '';

  home.sessionVariables.KUBECONFIG = "${config.xdg.configHome}/k3s/k3s.yaml";
}
