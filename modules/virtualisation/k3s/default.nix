{ config, lib, pkgs, ... }:{
  config = lib.mkIf config._k3s {
    services.k3s = {
      enable       = true;
      package      = pkgs.k3s;
      role         = "server";      # server, agent
      # disableAgent = true;        # when role server
      # clusterInit  = true;        # for HA cluster with an embedded etcd
      extraFlags   = toString ([
        "--write-kubeconfig-mode \"0600\""    # /etc/rancher/k3s/k3s.yaml
        "--disable traefik"
        "--data-dir=/var/lib/rancher/k3s"   
        "--tls-san ${config._hostName}"       # required to use the API server by his hostname
        # "--cluster-cidr 10.42.0.0/16"        KO # IPv4/IPv6 network CIDRs to use for pod IPs
        # "--server-cidr 10.43.0.0/16"         KO # IPv4/IPv6 network CIDRs to use for service
        # "--debug"
        # "--flannel-iface eno1"               # old: flannel.1
        # "--disable servicelb"
        # "--server https://192.168.1.66:6443"
        # "--disable network-policy"
        # "--disable cloud-controller"
        # "--disable metrics-server"
        # "--disable local-storage"
      ]);
      # tokenFile = /var/lib/rancher/k3s/server/token;
      # token =             # k3s token to use when connecting to a server, WARNING: expose your token unencrypted
      # configPath =        # File path containing the k3s YAML config
      # environmentFile =   # File path containing environment variables for configuring the k3s service in the format of an EnvironmentFile
      # serverAddr = "https://10.0.0.10:6443";      # The k3s server to connect to
      # charts = ../charts/argocd.tgz;
    };
  };

  imports = [
    # ./path_permissions.nix
    ./network.nix
  ];
}
