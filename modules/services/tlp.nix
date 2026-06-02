{
  flake.aspects.tlp.nixos = { lib, ... }:{
    services.tlp = {
      enable   = true;
      settings = {
        # keep battery level as close to 50% as possible
        START_CHARGE_THRESH_BAT0 = 41;
        STOP_CHARGE_THRESH_BAT0  = lib.mkDefault 61;
        START_CHARGE_THRESH_BAT1 = 41;
        STOP_CHARGE_THRESH_BAT1  = 61;
      };
    };
  };
}
