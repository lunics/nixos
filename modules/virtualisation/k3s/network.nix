{
  networking.firewall = {
    enable = true;

    allowedTCPPorts = [
      80
      443
      6443        # k3s: required so that pods can reach the API server (running on port 6443 by default)
      8080        # global web access
      # 2379      # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
      # 2380      # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
      # 53317     # localsend still KO
    ];
  };
}

