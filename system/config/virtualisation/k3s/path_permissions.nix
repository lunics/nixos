{ config, lib, ... }:{
  config = lib.mkIf config._.k3s {
    systemd.tmpfiles.rules = [
      # "d /opt/k3s 0775 lunics data -"
      # "d /opt/k3s/data 0775 lunics data -"
      # "d /home/${user}/.kube 0775 lunics data -"
      # "d /var/lib/rancher/k3s/server/manifests 0775 root data -"
      # "d /opt/k3s 0775 lunics -"
      # "d /opt/k3s/data 0775 lunics -"     # unused, default is /var/lib/rancher/k3s/data
      "d /var/lib/rancher/k3s/server/manifests 0775 root -"
      # "d /home/lunics/.config/k3s 0775 lunics -"                                  # only for local cluster
      # "L /home/lunics/.config/k3s/k3s.yaml  - - - - /etc/rancher/k3s/k3s.yaml"    # only for local cluster
      # "L /var/lib/rancher/k3s/server/manifests/00-coredns-custom.yaml - - - - /etc/k3s/coredns-custom.yaml" # use 00- prefix to deploy this first
    ];
  };
}
