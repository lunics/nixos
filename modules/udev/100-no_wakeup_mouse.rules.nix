{
  services.udev.extraRules = ''
    SUBSYSTEM=="usb"
    ACTION=="add"
    DRIVERS=="usb"
    ATTRS{idVendor}=="{{ item.id_vendor }}"
    ATTRS{idProduct}=="{{ item.id_product }}"
    ATTR{power/wakeup}="disabled"
    ATTR{driver/1-1.1.1.4/power/wakeup}="disabled"
  '';
 }
