{
  # X Server may fail to start with the newer 12th generation, Alder Lake, iRISxe integrated graphics chips
  boot.kernelParams = [ "i915.force_probe=DEVICE_ID" ];   # lspci -nn | grep VGA
}
