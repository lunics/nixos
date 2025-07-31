{ config, lib, ... }:{
  options._.zramSwap = {
    enable = lib.mkEnableOption "";

    memoryPercent = lib.mkOption {
      default = 50;  # 50% of ZRAM
      type    = lib.types.int;
    };
  };
}
