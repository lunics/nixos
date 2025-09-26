{
  boot.loader.systemd-boot = {
    enable             = true;
    editor             = false;     # allow editing the kernel command-line before boot
    consoleMode        = "auto";    # 0, 1, 2, 5, auto, max, keep
    configurationLimit = 20;        # Maximum number of latest generations in the boot menu to to prevent boot partition running out of space
    rebootForBitlocker = false;     # experimental BitLocker support
    graceful           = false;     # invoke bootctl install with the --graceful option
    edk2-uefi-shell    = {          # make the EDK2 UEFI Shell available from the systemd-boot menu
      enable  = false;
      sortKey = "o_edk2-uefi-shell";
    };
    memtest86 = {                   # make Memtest86+ available from the systemd-boot menu
      enable = false;
      sortKey = "o_memtest86";
    };
    netbootxyz = {
      enable = false;
      sortKey = "o_netbootxyz";
    };

    # xbootldrMountPoint =    # where the XBOOTLDR partition is mounted
    # sortKey =                 # sort key used for the NixOS bootloader entries
    # installDeviceTree = with config.hardware.deviceTree; enable &amp;&amp; name != null;
    #   Install the devicetree blob specified by config.hardware.deviceTree.name to the ESP and instruct systemd-boot to pass this DTB to linux
    # extraInstallCommands = ''     # shell commands inserted in the bootloader installer script after generating menu entries
    #   default_cfg=$(cat /boot/loader/loader.conf | grep default | awk '{print $2}')
    #   init_value=$(cat /boot/loader/entries/$default_cfg | grep init= | awk '{print $2}')
    #   sed -i "s|@INIT@|$init_value|g" /boot/custom/config_with_placeholder.conf
    # '';
    # extraFiles = {                # set of files to be copied to $BOOT
    #   "efi/memtest86/memtest.efi" = "${pkgs.memtest86plus}/memtest.efi"; 
    # };
    # extraEntries = { 
    #   "memtest86.conf" = ''
    #     title Memtest86+
    #     efi /efi/memtest86/memtest.efi
    #     sort-key z_memtest
    #   ''; 
    # };

    # Make Windows bootable from systemd-boot
    # not necessary when Windows and NixOS use the same EFI System Partition (ESP)
    # windows = {               # if Windows is installed on a separate drive or ESP, add a menu entry for each distro
    #   "10".efiDeviceHandle = "HD0c3";
    #   "11-ame" = {
    #     title = "Windows 11 Ameliorated Edition";
    #     efiDeviceHandle = "HD0b1";
    #   };
    #   "11-home" = {
    #     title = "Windows 11 Home";
    #     efiDeviceHandle = "FS1";
    #     sortKey = "z_windows";
    #   };
    # };
  };
}
