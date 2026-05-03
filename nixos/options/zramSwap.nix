{ config, lib, ... }: with lib; {
  options._.zramSwap = {
    enable = mkEnableOption "";

    memoryPercent = mkOption {
      default = 50;  # 50% of ZRAM
      type    = types.int;
    };
  };
}
