{
  flake.aspects.graphic.nixos = {
    # X server may fail to start with 12th gen Alder Lake iRISxe integrated graphics
    # get DEVICE_ID: lspci -nn | grep VGA
    boot.kernelParams = [ "i915.force_probe=DEVICE_ID" ];
  };
}
