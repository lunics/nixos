{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      k3s = {
        enable = mkEnableOption "";
        user = mkOption {
          type    = types.str;
          default = "kube";
        };
      };
    };
  };
}
