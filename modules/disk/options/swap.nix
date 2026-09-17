{
  flake.aspects.options.generic = { config, lib, ... }: with lib; {
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
          default = "8G";   # at least the RAM size to hold the hibernation image
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
