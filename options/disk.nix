{ config, lib, ... }: with lib; {
  options._.disk = {
    device = mkOption {
      type    = types.str;
      default = "nvme0n1";
    };
    boot = mkOption {
      type    = types.str;
      default = "1G";
    };
    boot_uuid = mkOption {
      type    = types.str;
      default = "";           # required in dual boot
    };
    luks = mkOption {
      type    = types.bool;
      default = true;
    };
    luks_device = mkOption {
      type    = types.str;
      default = "";
    };
    btrfs_opts = mkOption {
      type    = types.listOf types.str;
      default = ["compress=zstd" "noatime" "lazytime" "space_cache=v2" "ssd"];
    };
    dual_boot = mkEnableOption "";
  };
}

