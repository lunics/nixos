{ lib, ... }:{
  networking = {
    hostName = "nixos";

    useDHCP = lib.mkDefault true;
    # interfaces.wlp3s0.useDHCP    = lib.mkDefault true;
  };
}
