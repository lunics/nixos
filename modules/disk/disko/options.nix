{
  flake.aspects.options.vars = { config, lib, ... }: with lib; {
    options._.disk = {
      device-by-id = mkOption {
        type  = types.str;
        apply = id: if hasPrefix "/" id then id else "/dev/disk/by-id/${id}"; # concat path to disk-id
      };
      boot-mode = mkOption {    # hybrid boots the same disk from bios and uefi firmwares
        type    = types.enum [ "uefi" "bios" "hybrid" ];
        default = "uefi";
      };
      boot_size = mkOption {
        type    = types.str;
        default = "1G";
      };
      boot-by-partuuid = mkOption {    # required in dual boot, gpt guid of the existing esp
        type    = types.nullOr types.str;
        default = null;
        apply   = id: if id == null || hasPrefix "/" id then id else "/dev/disk/by-partuuid/${id}"; # concat path to partuuid
      };
      firmware-size = mkOption {    # holds every generation with the kernel bootloader
        type    = types.str;
        default = "1G";
      };
      image-size = mkOption {    # only read when building a disko image, never when installing
        type    = types.nullOr types.str;
        default = null;
      };
      luks = mkOption {
        type    = types.bool;
        default = true;
      };
      luks_device = mkOption {
        type    = types.str;
        default = "";
      };
      luks_partuuid = mkOption {
        type    = types.nullOr types.str;
        default = null;
      };
      btrfs-partuuid = mkOption {
        type    = types.nullOr types.str;
        default = null;
      };
      btrfs_opts = mkOption {
        type    = types.listOf types.str;
        default = ["compress=zstd" "noatime" "lazytime" "space_cache=v2" "ssd"];
      };
      subvolumes = mkOption {    # merged into the disko btrfs layout, each aspect declares its own
        type = types.attrsOf (types.submodule {
          freeformType = types.attrs;    # the other disko subvolume options stay reachable
          options = {
            mountpoint = mkOption {
              type    = types.nullOr types.str;
              default = null;
            };
            mountOptions = mkOption {
              type    = types.listOf types.str;
              default = config._.disk.btrfs_opts;
            };
          };
        });
        default = {};
      };
      dual_boot = mkEnableOption "";
    };
  };
}
