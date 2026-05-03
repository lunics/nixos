{ config, lib, pkgs, ... }:{
  config = lib.mkIf config._.k3s {
    services.openiscsi = {    # required by longhorn
      enable             = true;
      package            = pkgs.openiscsi;
      name               = "iqn.2020-08.org.linux-iscsi.initiatorhost:example";
      extraConfigFile    = null;
      extraConfig        = "";
      enableAutoLoginOut = false;
      discoverPortal     = null;
    };
  };
}

