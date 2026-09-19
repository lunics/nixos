{ inputs, ... }:{
  flake-file.inputs = {
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
  };

  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._.raspberry-pi = mkEnableOption "";
  };

  flake.aspects.raspberry-pi.nixos = { config, lib, ... }:
  let
    boot-loader = config.boot.loader.raspberry-pi;
    x86         = import inputs.nixpkgs { system = "x86_64-linux"; };

    # vmTools gives the vm a single vcpu, and the core count is the builder's, not the board's
    # -cpu max stalls edk2 under tcg, the board's own core boots through
    qemu-smp = x86.writeShellScript "qemu-system-aarch64-smp" ''
      exec ${x86.qemu}/bin/qemu-system-aarch64 \
        -machine virt,gic-version=max,accel=tcg -cpu cortex-a72 -nic none \
        -smp "$(${x86.coreutils}/bin/nproc)" "$@"
    '';
  in {
    _ = {
      raspberry-pi     = true;                    # gates the board bits carried by the shared aspects
      disk.device      = "mmcblk0";
      disk.luks        = false;
      zram-swap.enable = true;
      state-version    = "26.05";                 # the fork pins nixpkgs 26.05
      disk.image-size  = lib.mkDefault "30500M";  # 29.8 GiB card, qemu-img reads G as GiB
    };

    # the board resolves the cache itself, for the rebuilds it runs on its own
    nix.settings = {
      substituters         = [ "https://nixos-raspberrypi.cachix.org" ];
      trusted-substituters = [ "https://nixos-raspberrypi.cachix.org" ];
      trusted-public-keys  = [ "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI=" ];
    };

    # native emulator for the image vm
    disko.imageBuilder.qemu = "${qemu-smp}";

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
