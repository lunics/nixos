{
  flake.aspects.disk.nixos = { config, lib, ... }: with lib;
  let
    _ = config._.disk;
  in {
    # vendor boot code, dtbs, and the generations themselves with the kernel bootloader
    config = mkIf config._.raspberry-pi {
      disko.devices.disk.${_.device}.content.partitions.firmware = {
        name       = "FIRMWARE";
        label      = "FIRMWARE";
        priority   = 1;          # disko orders by priority, the board boots off the first one
        size       = _.firmware-size;
        type       = "0700";     # microsoft basic data
        attributes = [ 0 ];      # required partition, keeps udisks from offering it
        content = {
          type         = "filesystem";
          format       = "vfat";
          mountpoint   = "/boot/firmware";
          extraArgs    = [ "-n" "FIRMWARE" ];
          mountOptions = [        # only read on rebuild, no need to keep a vfat mounted
            "noatime"
            "noauto"
            "x-systemd.automount"
            "x-systemd.idle-timeout=1min"
          ];
        };
      };
    };
  };
}
