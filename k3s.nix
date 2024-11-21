{ pkgs, ... }: let
  my-kubernetes-helm = with pkgs; wrapHelm kubernetes-helm {
    plugins = with pkgs.kubernetes-helmPlugins; [
      helm-secrets
      helm-diff
      helm-s3
      helm-git ];
  };

  my-helmfile = pkgs.helmfile-wrapped.override {
    inherit (my-kubernetes-helm) pluginsDir;   };
in {
  environment.systemPackages =  [
    my-kubernetes-helm
    my-helmfile
  ];

  services.k3s = {
    enable       = true;
    package      = pkgs.k3s;
    role         = "server";   # server, agent
    disableAgent = true;
    extraFlags   = toString ([
      "--write-kubeconfig-mode \"0600\""    # /etc/rancher/k3s/k3s.yaml
      "--cluster-init"
      "--disable servicelb"
      "--disable traefik"
      "--disable local-storage"
      "--disable network-policy"
      "--disable cloud-controller"
      "--disable metrics-server"
      # "--server https://homelab-0:6443"
      # "--cluster-cidr 10.24.0.0/16"
    ]);
    clusterInit = true;
    # tokenFile = /var/lib/rancher/k3s/server/token;
    # token =             # k3s token to use when connecting to a server, WARNING: expose your token unencrypted
    # configPath =        # File path containing the k3s YAML config
    # environmentFile =   # File path containing environment variables for configuring the k3s service in the format of an EnvironmentFile
    # serverAddr = "https://10.0.0.10:6443";      # The k3s server to connect to
    # charts =
  };

  # systemd.services.k3s.serviceConfig.ExecStartPre = "${pkgs.coreutils}/bin/sleep 60";

  # services.openiscsi = {
  #   enable = true;
  #   name = "iqn.2016-04.com.open-iscsi:${meta.hostname}";
  # };
}
