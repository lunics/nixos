{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    # mounted by disko when _.disk.btrfs_vol.kube, every k8s distribution keeps its state here
    options._.kubernetes.btrfs-subvol = mkOption {
      type    = types.str;
      default = "/var/lib/kubernetes";
    };
  };
}
