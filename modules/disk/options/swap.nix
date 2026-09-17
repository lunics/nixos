{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      zramSwap = {
        enable = mkEnableOption "";

        memoryPercent = mkOption {
          default = 50;  # 50% of ZRAM
          type    = types.int;
        };
      };

      swap = {
        enable = mkEnableOption "";   # btrfs swapfile subvolume, required to hibernate

        size = mkOption {
          default = "8G";   # at least the RAM size to hold the hibernation image
          type    = types.str;
        };

        priority = mkOption {
          default = 3;      # lower than zramSwap, used once zram is full
          type    = types.int;
        };

        resume_offset = mkOption {
          # btrfs inspect-internal map-swapfile -r /.swapvol/swapfile
          default = null;
          type    = types.nullOr types.int;
        };
      };
    };
  };
}
