{ boot = {

  initrd = {
    availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
    kernelModules = [ ];
    # luks.devices."luks-b6890844-2d38-4f35-807f-2ad2922ae9a5".device = "/dev/disk/by-uuid/b6890844-2d38-4f35-807f-2ad2922ae9a5";
    luks = {
      devices."luksroot".device = "/dev/disk/by-uuid/b6890844-2d38-4f35-807f-2ad2922ae9a5";
      fido2Support       = false;
      yubikeySupport     = false;
      mitigateDMAAttacks = true;    # blacklists FireWire drivers to avoid encryption keys stollen from a physical access via FireWire port, manually load the drivers if you need it.
      reusePassphrases   = true;    # Useful for mounting a number of devices that use the same passphrase without retyping it several times
    };
  };

  kernelModules = [ "kvm-intel" ];

  extraModulePackages = [ ];

  # Bootloader
  loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

};}
