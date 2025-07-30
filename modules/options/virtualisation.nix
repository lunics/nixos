{ config, lib, ... }:{
  options = {
    _virtualisation = lib.mkEnableOption "";

    _k3s = lib.mkOption {
      type    = lib.types.bool;
      default = config._virtualisation;
    };

    _waydroid = lib.mkOption {
      type    = lib.types.bool;
      default = config._virtualisation;
    };

    _libvirt = lib.mkOption {
      type    = lib.types.bool;
      default = config._virtualisation;
    };

    _docker = lib.mkOption {
      type    = lib.types.bool;
      default = false;
    };

    _podman = lib.mkOption {
      type    = lib.types.bool;
      default = false;
    };
  };
}

