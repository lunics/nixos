{
  # for the x86 machine building the board image, never for the board itself
  flake.aspects.rpi-image-builder.nixos = {
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

    _.disk.image-size = "32G";
  };
}
