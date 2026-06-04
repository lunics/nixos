{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      libvirt  = mkEnableOption "";
      k0s      = mkEnableOption "";
      docker   = mkEnableOption "";
      podman   = mkEnableOption "";
      waydroid = mkEnableOption "";

      # should be modified only from a flake.aspects.MVM-NAME.nixos._.from
      from = mkOption {       
        type    = types.str;
        default = "host";
      };
    };
  };
}
