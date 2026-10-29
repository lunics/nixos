{
  flake.aspects.devops.homeManager = { config, lib, ... }:{
    config = lib.mkIf config._.kube {
      _.persistent-home.dirs = [
        ".local/share/k9s"    # per cluster settings
        ".local/state/k9s"    # command history, screen dumps
      ];

      programs.k9s = {
        enable   = true;
        settings = {};
        aliases  = {};
        hotKeys  = {};
        plugins  = {};
        views    = {};
        skins    = {};
      };
    };
  };
}
