{
  flake.aspects.options.generic = { lib, pkgs, ... }: with lib; {
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
        kubectl = mkOption {
          type    = types.str;
          default = "${pkgs.kubectl}/bin/kubectl --kubeconfig /etc/rancher/k3s/k3s.yaml";
        };
      };

      argo-cd-repo-url = mkOption {
        type    = types.str;
        default = "";
      };
    };
  };
}
