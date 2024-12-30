{ pkgs, ... }:{
  home.packages = with pkgs; [
    kubectl
    kustomize
    kubie           # powerful alternative than kubectx and kubens
    kubectx         # To switch between kubectl contexts and Kubernetes namespaces
    kubecolor       # Colorize your kubectl output
    stern           # Log tailing for Kubernetes
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

  programs.k9s = {
    enable  = true;
    package = pkgs.k9s;
    # alias   = {};   KO does not exist  
      # # https://k9scli.io/topics/aliases/
      #   pp = "v1/pods"; # Use pp as an alias for Pod
      # };
    hotkey  = {};
      # Make sure this is camel case
      # hotKey = {
      #   shift-0 = {
      #     shortCut = "Shift-0";
      #     description = "Viewing pods";
      #     command = "pods";
      #   };
      # };
    plugin  = {};
    views   = {};
    skins   = {};
    settings = {
      k9s = {
        refreshRate = 2;
      };
    };
  };

}
