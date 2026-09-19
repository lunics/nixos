{
  flake-file.inputs = {
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
  };
  
  flake.aspects.raspberry-pi.nixos = {
    nixConfig = {
      extra-substituters = [
        "https://nixos-raspberrypi.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
      ];
    };
  };

  flake.aspects.raspberry-pi.nixos-raspberrypi = { config, ... }:
  let
    boot-loader = config.boot.loader.raspberry-pi;
  in {
    # board, bootloader and kernel readable from the generation label
    system.nixos.tags = [
      "raspberry-pi-${boot-loader.variant}"
      boot-loader.bootloader
      config.boot.kernelPackages.kernel.version
    ];
  };
}
