{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._.disk = {
      device-by-id = mkOption {
        description = "/dev/disk/by-id/nvme-...";
        type = types.str;
      };
      boot-mode = mkOption {    # hybrid boots the same disk from bios and uefi firmwares
        type    = types.enum [ "uefi" "bios" "hybrid" ];
        default = "uefi";
      };
      boot_size = mkOption {
        type    = types.str;
        default = "1G";
      };
      boot_uuid = mkOption {    # required in dual boot
        type    = types.nullOr types.str;
        default = null;
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
      luks-key-file = mkOption {
        type    = types.nullOr types.path;
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
      btrfs_vol = {
        persistent = mkEnableOption "";
        kube       = mkEnableOption "";
      };
      dual_boot = mkEnableOption "";
    };
  };
}
