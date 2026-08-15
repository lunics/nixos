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

        # performance ceiling as a % of max turbo frequency (intel_pstate)
        # 80 % of 5.0 GHz -> ~4.0 GHz
        CPU_MAX_PERF_ON_AC  = 80;
        CPU_MAX_PERF_ON_BAT = 50;

        # EPP: performance 0, balance_performance 128, balance_power (192), power (255)
        CPU_ENERGY_PERF_POLICY_ON_AC  = "balance_power";  # balance_performance (default)
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";          # balance_power (default)

        CPU_BOOST_ON_AC  = 1;   # 1 = enabled
        CPU_BOOST_ON_BAT = 0;   # 0 = disabled
      };
    };
  };
}
