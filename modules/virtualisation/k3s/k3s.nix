{
  flake.aspects.k3s.nixos = { config, lib, pkgs, ... }:{
    config = lib.mkIf config._.k3s.enable {
      services.k3s = {
        enable       = true;
        package      = pkgs.k3s;
        role         = "server";              # server, agent
        disableAgent = false;                 # false = the master node will also also schedules workloads (when rol = server); true = in worker node mode, needs role = agent too
        clusterInit  = false;                 # true = for HA cluster with an embedded etcd
        extraFlags   = toString ([
          "--data-dir=/var/lib/rancher/k3s"
          "--write-kubeconfig-mode \"0600\""  # /etc/rancher/k3s/k3s.yaml
          "--tls-san ${config._.hostname}"    # required to use the API server by its hostname
          "--disable traefik"
          "--cluster-cidr 10.42.0.0/16"       # IPv4/IPv6 network CIDRs to use for pod IPs
          "--service-cidr 10.43.0.0/24"       # IPv4/IPv6 network CIDRs to use for services
          # "--flannel-iface flannel.1"
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
          # NAME = {
          #   enable  = true;
          #   content = {};
          #   source  = ../path/argo-cd.yml;
          #   target  = "manifest.yml";       # defaults to the attribute name
          # };
        };

        gracefulNodeShutdown = {
          enable                          = true;
          shutdownGracePeriod             = "30s";
          shutdownGracePeriodCriticalPods = "10s";
        };

        # extraKubeletConfig = {
        #   containerLogMaxSize = "5Mi";
        #   memoryThrottlingFactor = 0.69;
        #   podsPerCore = 3;
        # };

        # extraKubeProxyConfig = {
        #   clientConnection.kubeconfig = "/var/lib/rancher/k3s/agent/kubeproxy.kubeconfig";
        #   mode = "nftables";
        # };

        # tokenFile = /var/lib/rancher/k3s/server/token;
        # token =           # WARNING: exposes your token unencrypted
        # configPath =      # file path containing the k3s YAML config
        # environmentFile = # file path containing environment variables
        # serverAddr = "https://10.0.0.10:6443";
      };

      ## delete later if we can generate the k3s.yaml
      # systemd.services.k3s.postStart = ''
      #   if [ -f /etc/rancher/k3s/k3s.yaml ]; then
      #     chown ${config._.k3s.user} /etc/rancher/k3s/k3s.yaml
      #   fi
      # '';

      _.persistent.dirs = lib.mkIf config._.impermanence [ "/kube" ];

      # systemd.tmpfiles.rules = [
      #   "C /var/lib/rancher/k3s/server/manifests/argo-cd.yml 0644 root root - ${./argo-cd.yml}"
      # ];
    };
  };
}
