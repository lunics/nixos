{ config, lib, ... }:{
  config = lib.mkIf (config._.boot_loader == "grub") {
    boot.loader.grub = {
      enable            = true;
      efiSupport        = true;
      device            = "nodev";      # nodev = a GRUB boot menu will be generated, but GRUB itself will not actually be installed
      devices           = [];
      default           = "0";          # default menu item to be booted
      fontSize          = 18;
      fsIdentifier      = "uuid";       # uuid, label, provided; How GRUB will identify devices when generating the configuration file
      storePath         = "/nix/store";
      useOSProber       = false;
      timeoutStyle      = "menu";       # menu (shows the menu), countdown (text-mode countdown), hidden
      configurationName = "";

      # mirroredBoots."NAME" = {
      #   path             = "/boot"; # boot directory where GRUB will be written
      #   devices          = [];
      #   efiSysMountPoint = null;    # path to the efi system mount point, can be left as null or "/boot/efi"
      #   efiBootloaderId  = null;    # id of the bootloader to store in efi nvram, only used if boot.loader.efi.canTouchEfiVariables = true
      # };

      # users = {
      #   root = {
      #     hashedPasswordFile = "/path/to/file";
      #   };
      # };

      # splashImage = "./my-background.png";  # must be: png, tga, jpg or jpeg; Background image
      # splashMode = "stretch";       # normal", stretch; Stretch the image or show the image in the top-left corner unstretched
      # theme = "${pkgs.libsForQt5.breeze-grub}/grub/themes/breeze";
    };
  };
}
