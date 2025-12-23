{ config, pkgs, ... }:{
  systemd.user = {
    timers."pomodoro" = {
      Unit = {
        Description = "pomodor.timer at boot and every 40 min";
        After       = [ "default.target" "suspend.target" ];
      };
      Timer = {
        OnBootSec       = "1min";
        OnUnitActiveSec = "40min";
        AccuracySec     = "1s";
      };
      Install.WantedBy  = [ "default.target" "suspend.target" ];
    };

    services."pomodoro" = {
      Unit = {
        Description = "a pomodoro.service cycle";
        Requires    = [ "pomodoro.timer" ];
        # After       = [ "default.target" "suspend.target" ];
      };
      Service = {
        Type      = "simple";     # oneshot is waiting until sleep finish
        ExecStart = [
          "${pkgs.bash}/bin/bash %h/.config/systemd/user/pomodoro.sh"
        ];
      };
      # Install.WantedBy = [ "suspend.target" ];
    };
  };

  xdg.configFile."systemd/user/pomodoro.sh".source = ./service_script.sh;
}
