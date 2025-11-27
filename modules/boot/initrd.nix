{
  boot.initrd = {
    systemd.enable = true;
    # network.enable = false;

    availableKernelModules = [ "xhci_pci" "thunderbolt" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
    IF LUKS AND YUBIKEY
      kernelModules = [ "vfat" "nls_cp437" "nls_iso8859-1" "usbhid" ];
    FI
    luks = {
      cryptoModules = [ "aes" "xts" "sha512" ];
      fido2Support       = false;
      mitigateDMAAttacks = true;    # blacklists FireWire drivers to avoid encryption keys stollen from a physical access via FireWire port, manually load the drivers if you need it.
      # reusePassphrases   = true;  # Useful for mounting a number of devices that use the same passphrase without retyping it several times

      IF LUKS AND YUBIKEY
        yubikeySupport     = false;
        devices = {
          "luks" = {
            device = "/dev/disk/by-uuid/3019cc95-1cc4-4f73-aec7-d5a030626aef";
            # preLVM = true; # set this to false if you need to start a network service first
            yubikey = {
              slot        = 1;
              twoFactor   = false;  # if using a user password as the 2nd factor
              gracePeriod = 30;     # time in seconds to wait for YubiKey to be inserted
              keyLength   = 64;     # set to $KEY_LENGTH/8
              saltLength  = 16;     # set to $SALT_LENGTH
              storage = {
                device = "$EFI_PART";
              };
            };
          };
        };
      FI
    };
  };
}
