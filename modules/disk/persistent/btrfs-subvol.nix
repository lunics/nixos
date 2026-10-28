{
  flake.aspects.persistent.nixos = { config, lib, ... }: with lib;
  let
    _ = config._.disk;
    # merged into the btrfs content declared by the disk aspect
    subvolumes."/persistent" = {
      mountpoint   = config._.persistent-system.dest;
      mountOptions = ["subvol=persistent"] ++ _.btrfs_opts;
    };
  in {
    config = mkMerge [
      (mkIf _.luks {
        disko.devices.disk.main.content.partitions.luks.content.content = { inherit subvolumes; };
      })
      (mkIf (! _.luks) {
        disko.devices.disk.main.content.partitions.btrfs.content = { inherit subvolumes; };
      })
    ];
  };
}
