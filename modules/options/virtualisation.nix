{ config, lib, ... }:{
  options = {
    _virtualisation = lib.mkEnableOption "";

    _waydroid = lib.mkOption {
      type    = lib.types.bool;
      default = config._virtualisation;
    };

    _libvirt = lib.mkOption {
      type    = lib.types.bool;
      default = config._virtualisation;
    };
  };
}

