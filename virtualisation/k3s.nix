{ pkgs, ... }:{
  services.k3s = {
    enable       = true;
    package      = pkgs.k3s;
    role         = "server";   # server, agent
    # disableAgent = true;
    extraFlags   = toString ([
      "--write-kubeconfig-mode \"0600\""    # /etc/rancher/k3s/k3s.yaml
    #   "--cluster-init"
    #   "--disable servicelb"
      "--disable traefik"
    #   "--disable network-policy"
    #   "--disable cloud-controller"
      "--disable metrics-server"
    #   # "--disable local-storage"
    #   # "--server https://homelab-0:6443"
    #   # "--cluster-cidr 10.24.0.0/16"
    ]);
    # clusterInit = true;
    # tokenFile = /var/lib/rancher/k3s/server/token;
    # token =             # k3s token to use when connecting to a server, WARNING: expose your token unencrypted
    # configPath =        # File path containing the k3s YAML config
    # environmentFile =   # File path containing environment variables for configuring the k3s service in the format of an EnvironmentFile
    # serverAddr = "https://10.0.0.10:6443";      # The k3s server to connect to
    # charts =
  };

  environment.systemPackages = with pkgs; [
    (wrapHelm kubernetes-helm {
      plugins = with pkgs.kubernetes-helmPlugins; [
        helm-secrets
        helm-diff
        helm-s3
        helm-git
      ];
    }) 
  ];
  systemd.tmpfiles.rules = [
    # "d /opt/k3s 0775 ***REMOVED*** data -"
    # "d /opt/k3s/data 0775 ***REMOVED*** data -"
    # "d /home/${user}/.kube 0775 ***REMOVED*** data -"
    # "d /var/lib/rancher/k3s/server/manifests 0775 root data -"
    "d /opt/k3s 0775 ***REMOVED*** -"
    "d /opt/k3s/data 0775 ***REMOVED*** -"
    "d /home/***REMOVED***/.config/k3s 0775 ***REMOVED*** -"
    "d /var/lib/rancher/k3s/server/manifests 0775 root -"
    "L /home/***REMOVED***/.config/k3s/k3s.yaml  - - - - /etc/rancher/k3s/k3s.yaml"
    # "L /var/lib/rancher/k3s/server/manifests/flux.yaml - - - - /etc/k3s/flux.yaml"
    # "L /var/lib/rancher/k3s/server/manifests/flux-git-auth.yaml - - - - ${config.age.secrets.flux-git-auth.path}"
    # "L /var/lib/rancher/k3s/server/manifests/flux-sops-age.yaml - - - - ${config.age.secrets.flux-sops-age.path}"
    # "L /var/lib/rancher/k3s/server/manifests/00-coredns-custom.yaml - - - - /etc/k3s/coredns-custom.yaml" # use 00- prefix to deploy this first
  ];
}
