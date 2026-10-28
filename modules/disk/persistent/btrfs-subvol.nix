{
  flake.aspects.persistent.nixos = { config, ... }:{
    # merged into the btrfs layout by the disk aspect
    _.disk.subvolumes."/persistent".mountpoint = config._.persistent-system.dest;
  };
}
