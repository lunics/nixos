{ boot = {

  initrd = {
    availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
    kernelModules = [ ];
    luks.devices."luks-b6890844-2d38-4f35-807f-2ad2922ae9a5".device = "/dev/disk/by-uuid/b6890844-2d38-4f35-807f-2ad2922ae9a5";
  };

  kernelModules = [ "kvm-intel" ];

  extraModulePackages = [ ];

  # Bootloader
  loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
