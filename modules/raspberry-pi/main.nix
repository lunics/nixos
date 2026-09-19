{
  flake-file.inputs = {
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
  };

  flake.aspects.raspberry-pi.nixos = { config, lib, ... }:
  let
    boot-loader = config.boot.loader.raspberry-pi;
  in {
    _.raspberry-pi = true;    # gates the board bits carried by the shared aspects

    _.zram-swap.enable = true;    # the only swap on the boards, no swapfile

    _.disk.image-size = lib.mkDefault "32G";    # card size, only read when building an image

    # the board resolves the cache itself, for the rebuilds it runs on its own
    nix.settings = {
      substituters         = [ "https://nixos-raspberrypi.cachix.org" ];
      trusted-substituters = [ "https://nixos-raspberrypi.cachix.org" ];
      trusted-public-keys  = [ "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI=" ];
    };

    boot.tmp.useTmpfs = true;
    boot.loader.raspberry-pi = {
      bootloader   = "kernel";            # kernelboot, uboot, kernel
      firmwarePath = "/boot/firmware";
    };

    # hardware.raspberry-pi.config = {};  # already managed by the flake

    # board, bootloader and kernel readable from the generation label
    system.nixos.tags = [
      "raspberry-pi-${boot-loader.variant}"
      boot-loader.bootloader
      config.boot.kernelPackages.kernel.version
    ];
  };
}
