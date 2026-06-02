{
  flake.aspects.k3s.nixos = { config, lib, ... }:{
    config = lib.mkIf config._.k3s.enable {
      systemd.tmpfiles.rules = [
        # "d /opt/k3s 0775 {config._.user} data -"
        # "d /opt/k3s/data 0775 {config._.user} data -"
        # "d /home/${user}/.kube 0775 {config._.user} data -"
        # "d /var/lib/rancher/k3s/server/manifests 0775 root data -"
        # "d /opt/k3s 0775 {config._.user} -"
        # "d /opt/k3s/data 0775 {config._.user} -"                    # unused, default is /var/lib/rancher/k3s/data
        "d /var/lib/rancher/k3s/server/manifests 0775 root -"
        # "d /home/{config._.user}/.config/k3s 0775 {config._.user} -"                        # only for local cluster
        # "L /home/{config._.user}/.config/k3s/k3s.yaml  - - - - /etc/rancher/k3s/k3s.yaml"   # only for local cluster
        # "L /var/lib/rancher/k3s/server/manifests/00-coredns-custom.yaml - - - - /etc/k3s/coredns-custom.yaml" # use 00- prefix to deploy this first
      ];
    };
  };
}
