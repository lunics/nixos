{
  services.udev.extraRules = ''
    SUBSYSTEMS=="usb"
    ATTRS{idVendor}=="***REMOVED***"
    ATTRS{idProduct}=="***REMOVED***"
    MODE="0666"
    GROUP="androiddev"
    SYMLINK+="android%n"
      or
    SUBSYSTEM=="usb", ATTR{idVendor}=="0b05", MODE="0660", GROUP="adbusers", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0b05", ATTR{idProduct}=="7770", SYMLINK+="android_adb"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0b05", ATTR{idProduct}=="7770", SYMLINK+="android_fastboot"
  '';
}
