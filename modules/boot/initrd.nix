{
  boot.initrd = {
    systemd.enable = true;

    availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
    kernelModules = [ ];
    luks = {
      # devices = {
      #   # Comment test
      #   "luks".device = "/dev/disk/by-uuid/3019cc95-1cc4-4f73-aec7-d5a030626aef";
      # };
      fido2Support       = false;
      yubikeySupport     = false;
      mitigateDMAAttacks = true;    # blacklists FireWire drivers to avoid encryption keys stollen from a physical access via FireWire port, manually load the drivers if you need it.
      # reusePassphrases   = true;  ## NOT USED ANYMORE ?
                                    # Useful for mounting a number of devices that use the same passphrase without retyping it several times
    };
  };
}
