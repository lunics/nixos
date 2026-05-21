{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._.disk = {
      device = mkOption {
        type    = types.str;
        default = "nvme0n1";
      };
      boot_size = mkOption {
        type    = types.str;
        default = "1G";
      };
      boot_uuid = mkOption {    # required in dual boot
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
