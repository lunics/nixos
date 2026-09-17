{
  flake.aspects.options.generic = { config, lib, ... }: with lib; let
    # installed RAM in GiB, smbios reports each module size in KiB
    _ram = foldl' add 0 (filter isInt (map (_dev: _dev.size or 0)
      (config.hardware.facter.report.smbios.memory_device or []))) / 1048576;
  in {
    options._ = {
      zramSwap = {
        enable = mkEnableOption "";

        memoryPercent = mkOption {
          type    = types.int;
          default = 50;  # 50% of ZRAM
        };

        priority = mkOption {
          type    = types.int;
          default = 5;
        };
      };

      swap = {
        enable = mkEnableOption "";   # btrfs swapfile subvolume, required to hibernate

        size = mkOption {
          type    = types.str;
          default = if _ram > 0 then "${toString _ram}G" else "8G";  # the image needs to hold the whole RAM
        };

        priority = mkOption {
          type    = types.int;
          default = config._.zramSwap.priority - 2;  # lower than zram, used once zram is full
        };

        resume_offset = mkOption {
          type    = types.nullOr types.int;
          # btrfs inspect-internal map-swapfile -r /.swapvol/swapfile
          default = null;
        };
      };
    };
  };
}
