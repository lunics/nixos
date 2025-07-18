{
  imports = [
    ../../modules/default.nix
  ];

  _audio           = true;
  _login_manager   = true;
  _window_manager  = true;
  _virtualisation  = true;
  _gaming          = true;
  _zramSwap.enable = true;
  _crypttab.text   = "luks-2590eb50-1395-4c41-955b-976a599e2a3f UUID=f03d5303-948c-4842-934c-727cbc5039be /home/lunics/usb_luks.key noauto";
}
