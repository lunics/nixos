{
  # the x86 machine running diskoImagesScript, then writing the card
  flake.aspects.rpi-image-builder.nixos = { pkgs, ... }:{
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

    environment.systemPackages = with pkgs; [
      bmaptool     # writes the mapped blocks only, and checksums each range
      qemu-utils   # qemu-img, to inspect or convert the image
    ];
  };
}
