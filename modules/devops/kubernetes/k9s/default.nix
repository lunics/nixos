{ config, lib, ... }:{
  config = lib.mkIf config._.kube {
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
}
