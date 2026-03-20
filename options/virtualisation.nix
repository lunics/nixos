{ config, lib, ... }: with lib; {
  options._ = {
    libvirt  = mkEnableOption "";
    k3s      = mkEnableOption "";
    docker   = mkEnableOption "";
    podman   = mkEnableOption "";
    waydroid = mkEnableOption "";
    microvm  = {
      enable = mkEnableOption "";
      vms = lib.mkOption {
        type    = lib.types.attrs;
        default = {};
      };
      ipv6 = mkEnableOption "";
    };
  };
}
