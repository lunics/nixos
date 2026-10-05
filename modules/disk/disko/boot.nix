{
  flake-file.inputs.disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.disk.nixos = { config, lib, ... }: with lib; let
    _ = config._.disk;
  in {
    config = mkMerge [
      # grub embeds its core image there, disko also fills boot.loader.grub.devices from it
      (mkIf (_.boot-mode != "uefi" && ! config._.raspberry-pi) {
        disko.devices.disk.main.content.partitions.bios = {
          size = "1M";
          type = "EF02";
        };
      })
      # the kernel bootloader writes the generations to the firmware partition, /boot is unused
      (mkIf (! _.dual_boot && ! config._.raspberry-pi) {
        disko.devices.disk.main.content.partitions = {
          boot = {
            name  = "ESP";
            label = "BOOT";
            size  = "${_.boot_size}";
            type  = if _.boot-mode == "bios" then "8300" else "EF00";
            content = {
              type         = "filesystem";
              format       = "vfat";
              mountpoint   = "/boot";
              mountOptions = [ "defaults" ];
            };
          };
        };
      })
      (mkIf _.dual_boot {
        disko.devices.nodev."/boot" = {
          device     = "/dev/disk/by-uuid/${_.boot_uuid}";
          mountpoint = "/boot";
          fsType     = "vfat";
        };
      })
    ];
  };
}
