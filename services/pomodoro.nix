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
        After       = [ "default.target" "suspend.target" ];
      };
      Service = {
        Type      = "simple";
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
