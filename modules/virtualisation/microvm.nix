{
  microvm = {
    hypervisor = "qemu";          # qemu, cloud-hypervisor
    qemu.extraArgs = [
      "-vnc" ":0"
      "-vga" "qxl"
      # needed for mounse/keyboard input via vnc
      "-device" "virtio-keyboard"
      "-usb"
      "-device" "usb-tablet,bus=usb-bus.0"
    ];
    mem        = 8192;
    vcpu       = 4;
    interfaces = [ 
      {
        type = "user";      # tap, user
        id = "qemu";
        mac = "02:00:00:01:01:01";
      }
    ];
    # interfaces = lib.optional (tapInterface != null) {
    #   type = "tap";
    #   id = tapInterface;
    #   mac = "00:00:00:00:00:02";
    # };

    shares = lib.optional (builtins.elem hypervisor hypervisorsWith9p) {
      tag = "ro-store";
      source = "/nix/store";
      mountPoint = "/nix/.ro-store";
    };
    writableStoreOverlay = "/nix/.rw-store";
    volumes = [ {
      image = "nix-store-overlay.img";
      mountPoint = config.microvm.writableStoreOverlay;
      size = 2048;
    } ];
    graphics.enable = false;
  };
}
