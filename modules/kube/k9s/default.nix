{ config, lib, ... }:{
  config = lib.mkIf config._.kube {
    programs.k9s = {
      enable   = true;
      # alias   = {};   KO does not exist  
        # # https://k9scli.io/topics/aliases/
        #   pp = "v1/pods"; # Use pp as an alias for Pod
        # };
      hotKeys  = {};
        # Make sure this is camel case
        # hotKey = {
        #   shift-0 = {
        #     shortCut = "Shift-0";
        #     description = "Viewing pods";
        #     command = "pods";
        #   };
        # };
      plugins  = {};
      views    = {};
      skins    = {};
      settings = {
        k9s = {
          refreshRate = 2;
        };
      };
    };
};
}
