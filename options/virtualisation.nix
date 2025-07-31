{ config, lib, ... }:{
  options._ = {
    virtualisation = lib.mkEnableOption "";

    k3s = lib.mkOption {
      type    = lib.types.bool;
      default = config._.virtualisation;
    };

    waydroid = lib.mkOption {
      type    = lib.types.bool;
      default = config._.virtualisation;
    };

    libvirt = lib.mkOption {
      type    = lib.types.bool;
      default = config._.virtualisation;
    };

    docker = lib.mkOption {
      type    = lib.types.bool;
      default = false;
    };

    podman = lib.mkOption {
      type    = lib.types.bool;
      default = false;
    };
  };
}

