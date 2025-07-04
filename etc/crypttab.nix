{
  environment.etc.crypttab = {
    enable = true;
    mode   = "0400";
    text   = ''
      # LUKSNAME DEVICE_UUID KEYFILE luks
      luks-2590eb50-1395-4c41-955b-976a599e2a3f UUID=f03d5303-948c-4842-934c-727cbc5039be /home/lunics/usb_luks.key
    '';
  };
}
