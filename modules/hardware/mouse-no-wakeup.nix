{
  flake.aspects.hid.nixos = { config, lib, ... }:
  let
    mouse = config._.mouse-usb-id;
  in {
    config = lib.mkIf (device.id_vendor != "") {
      services.udev.extraRules = ''
        ACTION=="add", \
          SUBSYSTEM=="usb", \
          DRIVERS=="usb", \
          ATTRS{idVendor}=="${mouse.id_vendor}", \
          ATTRS{idProduct}=="${mouse.id_product}", \
          ATTR{power/wakeup}="disabled"
      '';
    };
  };
}
