{ pkgs, ... }:{
  systemd.user = {
    timers."pomodoro" = {
      Unit.Description = "pomodor.timer triggered at boot then every 40 min";
      Timer = {
        OnBootSec       = "1min";
        OnUnitActiveSec = "40min";
        AccuracySec     = "1s";
      };
      Install.WantedBy  = [ "default.target" ];
    };

    services."pomodoro" = {
      Unit = {
        Description = "a pomodoro.service's phase out of 3";
        After       = [ "default.target" "suspend.target" ];
      };
      Service = {
        Type      = "oneshot";
        ExecStart = [
          "/home/lunics/.nix-profile/bin/systemctl restart pomodoro.timer"     # reset the timer after every resume of suspend
          "${pkgs.bash}/bin/bash %h/.config/systemd/user/pomodoro.sh"
        ];
      };
      Install.WantedBy = [ "suspend.target" ];
    };
  };

  home.file.".config/systemd/user/pomodoro.sh".source = ./pomodoro.sh;
}
