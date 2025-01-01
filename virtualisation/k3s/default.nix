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

  imports = [
    ./packages.nix
    ./path_permissions.nix
  ];
}
