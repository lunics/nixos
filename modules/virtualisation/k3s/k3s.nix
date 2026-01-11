{ config, lib, pkgs, ... }:{
  config = lib.mkIf config._.k3s {
    services.k3s = {
      enable       = true;
      package      = pkgs.k3s;
      role         = "server";              # server, agent
      disableAgent = false;                 # when role server
      clusterInit  = false;                 # for HA cluster with an embedded etcd
      extraFlags   = toString ([
        "--data-dir=/var/lib/rancher/k3s"   
        "--write-kubeconfig-mode \"0600\""  # /etc/rancher/k3s/k3s.yaml
        "--tls-san ${config._.hostName}"    # required to use the API server by his hostname
        "--disable traefik"
        "--cluster-cidr 10.42.0.0/16"       # IPv4/IPv6 network CIDRs to use for pod IPs
        "--service-cidr 10.43.0.0/24"       # IPv4/IPv6 network CIDRs to use for service
        # "--flannel-iface flannel.1"       # flannel.1, eno1
        # "--flannel-backend=vxlan"
        # "--debug"
        # "--disable servicelb"
        # "--server https://192.168.1.66:6443"
        # "--disable network-policy"
        # "--disable cloud-controller"
        # "--disable metrics-server"
        # "--disable local-storage"
      ]);
      manifests = {
        argo-cd.source = ./argo-cd.yml;

        # NAME = {
        #   enable  = true;
        #   content = {};
        #   source  = ../path/argo-cd.yml;
        #   target  = "manifest.yml";       # defaults to the attribute name
        # };
      };

      gracefulNodeShutdown = {
        enable = true;
        shutdownGracePeriod = "30s";
        shutdownGracePeriodCriticalPods = "10s";
      };

      # extraKubeletConfig = {
      #   containerLogMaxSize = "5Mi";
      #   memoryThrottlingFactor = 0.69;
      #   podsPerCore = 3;
      # }

      # extraKubeProxyConfig = {
      #   clientConnection = {
      #     kubeconfig = "/var/lib/rancher/k3s/agent/kubeproxy.kubeconfig";
      #   };
      #   mode = "nftables";
      # }

      # tokenFile = /var/lib/rancher/k3s/server/token;
      # token =             # k3s token to use when connecting to a server, WARNING: expose your token unencrypted
      # configPath =        # File path containing the k3s YAML config
      # environmentFile =   # File path containing environment variables for configuring the k3s service in the format of an EnvironmentFile
      # serverAddr = "https://10.0.0.10:6443";      # The k3s server to connect to
      # charts = ../charts/argocd.tgz;
    };

    systemd.services.k3s.postStart = ''
      if [ -f /etc/rancher/k3s/k3s.yaml ]; then
        chown lunics:users /etc/rancher/k3s/k3s.yaml
      fi
    '';

    # systemd.tmpfiles.rules = [
    #   "C /var/lib/rancher/k3s/server/manifests/argo-cd.yml 0644 root root - ${./argo-cd.yml}"
    # ];
  };
}
