{ config, ... }:
let
  device = config._.udev.disable_mouse_wakeup;
in {
  config = lib.mkIf (device.id_vendor != "") {
    services.udev.extraRules = ''
      SUBSYSTEM=="usb"
      ACTION=="add"
      DRIVERS=="usb"
      ATTRS{idVendor}=="${device.id_vendor}"
      ATTRS{idProduct}=="${device.id_product}"
      ATTR{power/wakeup}="disabled"
      ATTR{driver/1-1.1.1.4/power/wakeup}="disabled"
    '';
  };
 }
