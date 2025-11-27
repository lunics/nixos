{
  imports = [
    ./initrd.nix
    ./grub.nix
    ./systemd-boot.nix
    # ./plymouth.nix
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
    };
  };
}
