{
  imports = [
    ./grub.nix
    ./initrd.nix
    ./plymouth.nix
  ];

  boot = {
    kernelModules = [ "kvm-intel" ];

    extraModulePackages = [ ];

    loader = {
      timeout = 5;                          # seconds until loader boots the default menu item

      efi  = {
        canTouchEfiVariables = true;
        efiSysMountPoint     = "/boot";     # KO /boot/efi, TRY at live installation
      };

      systemd-boot = {
        enable      = true;
        consoleMode = "auto";   # 0, 1, 2, auto, max, keep
      };
    };
  };
}
