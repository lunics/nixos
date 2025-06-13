{ pkgs, ... }:{
  systemd.user = {
    timers."pomodoro" = {
      Unit.Description = "Pomodoro cycle timer";
      Timer = {
        OnBootSec       = "1min";
        OnUnitActiveSec = "40min";
        AccuracySec     = "1s";
      };
      Install.WantedBy  = [ "default.target" ];
    };

    services."pomodoro" = {
      Unit = {
        Description = "Pomodoro cycle service";
        After       = [ "default.target" ];
      };
      Service = {
        Type      = "simple";
        ExecStart = "${pkgs.bash}/bin/bash %h/.config/systemd/user/pomodoro.sh";
      };
    };
  };

  home.file.".config/systemd/user/pomodoro.sh".source = ./pomodoro.sh;
}
