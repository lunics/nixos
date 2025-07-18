{
  fileSystems = {
    "/persist".neededForBoot = true;
    "/var/log".neededForBoot = true;
    # "/mnt/usb_luks" = {     # KO breaks boot
    #   device = "/dev/disk/by-uuid/2590eb50-1395-4c41-955b-976a599e2a3f";
    #   fsType = "btrfs";
    # };
  };
}
