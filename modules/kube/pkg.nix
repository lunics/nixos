{ config, lib, pkgs, ... }:{
  config = lib.mkIf config._.kube {
    home.packages = with pkgs; [
      kubectl
      kustomize
      kubie           # powerful alternative than kubectx and kubens
      kubectx         # To switch between kubectl contexts and Kubernetes namespaces
      kubecolor       # kubectl wrapper used to add colors 
      stern           # Log tailing for Kubernetes
      argocd
      # kubelogin
      # kubelogin-oidc
      # kubeseal
      # kubernetes-helm
      # helm
      # jq
      # fluxcd
      # fluxctl     ## replaced by fluxcd, A VERIFIER # controller for the GitOps Kubernetes operator flux, remplacé par la commande flux ???
      # flux-bin      # permet d'installer flux sur le cluster et de modifier l'install
      # age
      # sops
      # tilt
      # unstable.kubernetes-polaris
      # unstable.kubeshark
      # unstable.k3d
      # unstable.k9s
      # unstable.teleport.client
    ];
  };
}
