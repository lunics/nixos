{ config, lib, ... }: with lib; {
  options._ = {
    libvirt        = mkEnableOption "";
    k3s            = mkEnableOption "";
    docker         = mkEnableOption "";
    podman         = mkEnableOption "";
    waydroid       = mkEnableOption "";
  };
}

