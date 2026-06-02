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

      # should be modified only from a flake.aspects.MVM-NAME.nixos._.from
      from = mkOption {       
        type    = types.str;
        default = "host";
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
