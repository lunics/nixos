{
  # needed for battery level on hyprpanel
  services.upower = {
    enable                 = true;
    # package              = pkgs.upower;
    noPollBatteries        = false;           # don't poll the kernel for battery level changes
    ignoreLid              = false;                  # ignore the lid state
    usePercentageForPolicy = true;            # enable policy for warnings and action based on battery levels
    timeLow                = 1200;                     # if usePercentageForPolicy = false, time remaining in seconds at which UPower will consider the battery low
    timeCritical           = 300;             # // will consider the battery low critical
    timeAction             = 120;             # // will take action for the critical battery level
    criticalPowerAction    = "HybridSleep";   # PowerOff, Hibernate, HybridSleep, Suspend, Ignore;  action to take when timeAction or percentageAction has been reached for the batteries (UPS or laptop batteries) supplying the computer
    percentageLow          = 20;              # if usePercentageForPolicy = true, levels at which UPower will consider the battery low
    percentageCritical     = 5;               # // will consider the battery critical
    percentageAction       = 2;               # // will take action for the critical battery level
    enableWattsUpPro       = false;
    allowRiskyCriticalPowerAction = false;    # risky critical power actions "Suspend" and "Ignore"
  };
}
