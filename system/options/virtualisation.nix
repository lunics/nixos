{ config, lib, ... }: with lib; {
  options._ = {
    virtualisation = mkEnableOption "";

    k3s = mkOption {
      type    = types.bool;
      default = config._.virtualisation;
    };

    waydroid = mkOption {
      type    = types.bool;
      default = config._.virtualisation;
    };

    libvirt = mkOption {
      type    = types.bool;
      default = config._.virtualisation;
    };

    docker = mkOption {
      type    = types.bool;
      default = false;
    };

    podman = mkOption {
      type    = types.bool;
      default = false;
    };
  };
}

