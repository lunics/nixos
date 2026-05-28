{
  flake.aspects.boot.nixos = { config, ... }:{
    boot.initrd = {
      systemd.enable = true;
      network.enable = false;

      availableKernelModules = ["xhci_pci" "thunderbolt" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];

      luks = {
        cryptoModules      = ["aes" "xts" "sha512"];
        mitigateDMAAttacks = true;      # blacklists FireWire drivers to avoid encryption keys stollen from a physical access via FireWire port, manually load the drivers if you need it.

        # must be commented because not used by systemd stage 1
        # fido2Support     = config._.yubikey; # add systemd‑cryptenroll's FIDO2 support into the initrd so the initramfs can unlock LUKS volumes using a FIDO2 device at boot
        # reusePassphrases = false;     # has no effect with systemd stage 1. useful for mounting a number of devices that use the same passphrase without retyping it several times
        yubikeySupport     = false;     # OLD: to support the non‑FIDO2 YubiKey LUKS integration based on ykchalresp (challenge–response)
        gpgSupport         = false;

        devices = {
          "luks" = {
            # device           = config._.disk.luks_device;  # refers to the existing encrypted block device, conflic with disko.luks.label
            allowDiscards      = false; # required for discard=async for continuous TRIM
                                        # improves performance on SSD storage but has security implications
                                        # Use periodic TRIM instead: systemctl enable fstrim.timer
            bypassWorkqueues   = true;  # increase SSD performance

            fido2 = {
              passwordLess = true;      # Enable only when your device is PIN protected
              gracePeriod  = 10;        # seconds to wait for the FIDO2 key
              credentials  = [];        # multiple FIDO2 keys for the same luks device
            };

            preOpenCommands    = "";    # commands that should be run right before we try to mount our LUKS device, useful, if the keys needed to open the drive is on another partition
            postOpenCommands   = "";
            tryEmptyPassphrase = false; # if keyFile fails then try an empty passphrase first before prompting for password
            fallbackToPassword = false; # fallback to interactive passphrase prompt if the keyfile cannot be found, this prevent unattended boot should the keyfile go missing
            # preLVM           = false; # luksOpen will be attempted before LVM scan, set this to false if you need to start a network service first
                                        # must be commented because not used by systemd stage 1

            header             = null;
            keyFile            = config._.disk.luks-key-file;
            keyFileTimeout     = null;
            keyFileSize        = null;
            keyFileOffset      = null;

            # yubikey = {               # if yubikeySupport is true
            #   slot        = 1;
            #   twoFactor   = false;    # if using a user password as the 2nd factor
            #   gracePeriod = 30;       # time in seconds to wait for YubiKey to be inserted
            #   keyLength   = 64;       # set to $KEY_LENGTH/8
            #   saltLength  = 16;       # set to $SALT_LENGTH
            #   storage = {
            #     device = "$EFI_PART";
            #   };
            # };
          };
        };
      };
    };
  };
}
