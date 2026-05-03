{ config, ... }:{
  zramSwap = {
    enable        = config._.zramSwap.enable;
    memoryPercent = config._.zramSwap.memoryPercent;
    priority      = 5;
    algorithm     = "zstd";
  };
}
