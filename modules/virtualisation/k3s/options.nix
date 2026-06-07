{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      k3s = {
        enable = mkEnableOption "";
        user = mkOption {
          type    = types.str;
          default = "kube";
        };
        master-node-ip = mkOption {
          type    = types.str;
          default = "127.0.0.1";
        };
      };

      argo-cd-repo-url = mkOption {
        type    = types.str;
        default = "";
      };
    };
  };
}
