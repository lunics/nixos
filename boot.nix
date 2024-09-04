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

  loader = {
    grub = {
      efiSupport  = true;
      device      = "nodev";
      default     = "0";            # default menu item to be booted
      fontSize    = 18;
      configurationName = "";
      fsIdentifier = "uuid";        # uuid, label, provided; How GRUB will identify devices when generating the configuration file
      storePath = "/nix/store";
      useOSProber = false;

      timeoutStyle = "menu";        # menu (shows the menu), countdown (text-mode countdown), hidden

      # users = {
      #   root = {
      #     hashedPasswordFile = "/path/to/file";
      #   };
      # };

      # splashImage = "./my-background.png";  # must be: png, tga, jpg or jpeg; Background image
      # splashMode = "stretch";       # normal", stretch; Stretch the image or show the image in the top-left corner unstretched
      # theme = "${pkgs.libsForQt5.breeze-grub}/grub/themes/breeze";
    };

    efi  = {
      canTouchEfiVariables = true;
      efiSysMountPoint     = "/boot";     # KO /boot/efi, TRY at live installation
    };
  };

};}
