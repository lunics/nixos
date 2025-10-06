{
  imports = [
    ./grub.nix
    ./initrd.nix
    ./plymouth.nix
    ./systemd-boot.nix
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
