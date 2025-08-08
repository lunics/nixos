{ config, pkgs, ... }:{
  systemd.user = {
    timers."pomodoro" = {
      Unit = {
        Description = "pomodor.timer triggered at boot then every 40 min";
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
        Description = "one part of a pomodoro.service cycle";
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

  home.file.".config/systemd/user/pomodoro.sh".source = ./pomodoro.sh;
}
