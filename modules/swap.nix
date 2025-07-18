{ config, ... }:{
  zramSwap = {
    enable        = config._zramSwap.enable;
    memoryPercent = config._zramSwap.memoryPercent;
    priority      = 5;
    algorithm     = "zstd";
  };
}
