{
  flake.modules.nixos.disko = { config, lib, ... }: with lib; let
    _ = config._.disk;
  in {
    config = mkMerge [
      (mkIf (! _.dual_boot) {
        disko.devices.disk.${_.device}.content.partitions = {
          boot = {
            label = "BOOT";
            name  = "ESP";
            size  = "${_.boot_size}";
            type  = "EF00";
            content = {
              type         = "filesystem";
              format       = "vfat";
              mountpoint   = "/boot";
              mountOptions = [ "defaults" ];
            };
          };
        };
      })
      (mkIf (_.dual_boot) {
        disko.devices.nodev."/boot" = {
          device     = "/dev/disk/by-uuid/${_.boot_uuid}";
          mountpoint = "/boot";
          fsType     = "vfat";
        };
      })
    ];
  };
}
