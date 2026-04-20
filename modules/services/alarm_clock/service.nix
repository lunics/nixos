{ config, lib, pkgs, ... }:{
  # config = lib.mkIf (config._.alarm-clock){
    systemd.user = {
      timers."alarm-clock" = {
        Unit.Description = "triger alarm-clock.service everyday at 8am";
        Timer = {
          OnCalendar = "*-*-* 08:00:00";
          Persistent = false;       # don't play the alarm later if the PC is off
        };
        Install.WantedBy = [ "timers.target" ];
      };

      services."alarm-clock" = {
        Unit.Description = "Morning alarm clock";
        Service = {
          Type      = "oneshot";
          ExecStart = [ "${pkgs.alarm-clock}/bin/alarm-clock" ];
        };
      };
    };
  # };
}
