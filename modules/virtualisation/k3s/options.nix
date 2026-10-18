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
        btrfs-subvol = mkOption {
          type    = types.str;
          default = "/var/lib/kubernetes";
        };
      };

      openbao.snapshot = {
        enable = mkOption {
          type    = types.bool;
          default = true;
        };
        dir = mkOption {
          type    = types.str;
          default = "/var/lib/openbao-snapshots";   # same disk as the raft storage, point it elsewhere for a real backup
        };
        keep-days = mkOption {
          type    = types.ints.positive;
          default = 14;
        };
      };

      argo-cd-repo-url = mkOption {
        type    = types.str;
        default = "";
      };
    };
  };
}
