{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    # mounted by disko as its own btrfs subvolume, every k8s distribution keeps its state here
    options._.kubernetes.btrfs-subvol = mkOption {
      type    = types.str;
      default = "/var/lib/kubernetes";
    };
  };
}
