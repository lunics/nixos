{
  flake.aspects.rpi-image-builder = {
    # the x86 machine running diskoImagesScript, then writing the card
    nixos = { pkgs, ... }:{
      boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

      environment.systemPackages = with pkgs; [
        bmaptool     # writes the mapped blocks only, and checksums each range
        qemu-utils   # qemu-img, to inspect or convert the image
      ];
    };

    # the size is read from the board config, a plain nixos host never sees it
    nixos-raspberrypi = {
      _.disk.image-size = "32G";
    };
  };
}
