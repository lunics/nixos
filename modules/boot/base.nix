{
  flake.aspects.boot.nixos = { config, lib, ... }:
  let
    boot-mode = config._.disk.boot-mode;
  in {
    assertions = [{
      assertion = boot-mode == "uefi" || config.boot.loader.grub.enable;
      message   = "_.disk.boot-mode = \"${boot-mode}\" requires the grub aspect";
    }];

    boot = {
      extraModulePackages = [];

      loader = {
        timeout = 5;                        # seconds until loader boots the default menu item

        efi = lib.mkIf (boot-mode != "bios") {
          canTouchEfiVariables = boot-mode == "uefi";   # hybrid installs to the removable path instead
          efiSysMountPoint     = "/boot";               # will install in /boot/EFI, /boot/efi isn't compatible
        };
      };
    };
  };
}
