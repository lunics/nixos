{ config, lib, pkgs, ... }:{
  config = lib.mkIf (! config._.k3s) {
    systemd.tmpfiles.rules = [
      "R /var/lib/rancher/k3s"
      "R /var/lib/cni"
      "R /run/flannel"
      "R /var/run/flannel"
    ];
  };
}
