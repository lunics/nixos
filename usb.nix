{ pkgs, ... }:{

  services.usbguard = {
    enable      = false;
    dbus.enable = true;
    implicitPolicyTarget = "block";
    ## change {id} to your trusted USB device: lsusb
    rules = ''
      allow id {id} # device 1
      allow id {id} # device 2
    '';
  };

  environment.systemPackages = with pkgs; [
    usbutils  # for lsusb
  ];
}
