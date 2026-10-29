{
  flake.aspects.devops.homeManager = { config, lib, pkgs, ... }:{
    config = lib.mkIf config._.kube {
      _.persistent-home.dirs = [ ".config/helm" ];    # repositories.yaml

      home.packages = with pkgs; [
        (wrapHelm kubernetes-helm {
          plugins = with pkgs.kubernetes-helmPlugins; [
            helm-secrets
            helm-diff
            helm-s3
            helm-git
          ];
        }) 
      ];
    };
  };
}
