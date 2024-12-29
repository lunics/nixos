{
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
