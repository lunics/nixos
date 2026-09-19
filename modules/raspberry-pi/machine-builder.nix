{
  # the x86 machine running diskoImagesScript, then writing the card
  flake.aspects.rpi-image-builder.nixos = { pkgs, ... }:{
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

    nix.settings = {
      substituters         = [ "https://nixos-raspberrypi.cachix.org" ];
      trusted-substituters = [ "https://nixos-raspberrypi.cachix.org" ];
      trusted-public-keys  = [ "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI=" ];
    };

    environment.systemPackages = with pkgs; [
      bmaptool     # writes the mapped blocks only, and checksums each range
      qemu-utils   # qemu-img, to inspect or convert the image
    ];
  };
}
