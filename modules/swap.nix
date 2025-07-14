{
  zramSwap = {
    enable        = true;
    memoryPercent = 50;       # 50% of ZRAM
    priority      = 5;
    algorithm     = "zstd";
  };
}
