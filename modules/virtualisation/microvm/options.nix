{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
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
