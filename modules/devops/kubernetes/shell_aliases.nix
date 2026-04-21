{ config, lib, ... }:{
  config = lib.mkIf config._.kube {
    home.shellAliases = {
      k       = "kubecolor --cache-dir ~/.cache/kube";    # --no-headers
      kk      = "c $LINUX/kubernetes";
      kcc     = "k config current-context";
      kg      = "k get";
      ka      = "k get all --all-namespaces";
      knodes  = "k get nodes -o wide";
      kp      = "k get pods --all-namespaces -o wide";
      ks      = "k get services";
      kt      = "k top nodes --use-protocol-buffers; echo; k top pods --use-protocol-buffers";
      kd      = "k get deployments --all-namespaces";
      kv      = "k get pv,pvc";
      kapply  = "k apply -f";
      ki      = "k get ingresses.networking.k8s.io --all-namespaces";
      # helm    = "/run/current-system/sw/bin/helm";    ## replace by home-manager path ?
    };

    programs.zsh.initContent = ''
      source <(kubectl completion zsh)    # get zsh complete kubectl
      alias kubectl=kubecolor
      compdef kubecolor=kubectl           # make completion work with kubecolor
    '';
  };
}
