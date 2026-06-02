{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      libvirt  = mkEnableOption "";
      k0s      = mkEnableOption "";
      k3s      = mkEnableOption "";
      docker   = mkEnableOption "";
      podman   = mkEnableOption "";
      waydroid = mkEnableOption "";
      microvm  = {
        enable = mkEnableOption "";
        sops   = mkEnableOption "";
        vms = mkOption {
          type    = types.attrs;
          default = {};
        };
      };
    };
  };
}
