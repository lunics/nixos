{
  services.tlp = {
    enable   = true;
    settings = {
      # we want to stay as much at possibe at 50%
      START_CHARGE_THRESH_BAT0 = 41;
      STOP_CHARGE_THRESH_BAT0  = 61;
      START_CHARGE_THRESH_BAT1 = 41;
      STOP_CHARGE_THRESH_BAT1  = 61;
    };
  };
}
