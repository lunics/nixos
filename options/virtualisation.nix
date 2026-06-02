{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      libvirt  = mkEnableOption "";
      k0s      = mkEnableOption "";
      docker   = mkEnableOption "";
      podman   = mkEnableOption "";
      waydroid = mkEnableOption "";

      k3s = {
        enable = mkEnableOption "";
        user = mkOption {
          type    = types.str;
          default = "kube";
        };
      };

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
