{
  imports = [
    ./initrd.nix
    ./grub.nix
    ./systemd-boot.nix
    ./lanzaboot.nix
    ./plymouth.nix
  ];

  boot = {
    kernelModules = [ "kvm-intel" ];

    extraModulePackages = [ ];

    loader = {
      timeout = 5;                          # seconds until loader boots the default menu item

      efi  = {
        canTouchEfiVariables = true;
        efiSysMountPoint     = "/boot";     # will install in /boot/EFI, /boot/efi isn't compatible
      };
    };
  };
}
