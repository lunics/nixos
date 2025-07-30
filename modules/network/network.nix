{ config, lib, ... }:{
  networking = {
    hostName = config._.hostName;

    useDHCP = lib.mkDefault true;

    # interfaces.wlp3s0.useDHCP    = lib.mkDefault true;
  };
}
