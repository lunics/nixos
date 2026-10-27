{
  flake.aspects.k3s.nixos = { config, lib, ... }:{
    config = lib.mkIf (! config._.k3s.enable) {
      systemd.tmpfiles.rules = [
        "R ${config._.k3s.data-dir}"
        "R /var/lib/cni"
        "R /run/flannel"
        "R /var/run/flannel"
      ];
    };
  };
}
