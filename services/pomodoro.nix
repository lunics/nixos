{
  systemd.user.targets."suspend" = {
    Unit = {
      Description = "User level suspend target";
      StopWhenUnneeded = true;
      Wants = [ "pomodoro.service" ];
    };
  };

  systemd.user.services."pomodoro" = {
    Unit.Description  = "Pomodoro";
    Service.ExecStart = "/run/current-system/sw/bin/bash %h/.config/systemd/user/pomodoro.sh";
    Install.WantedBy  = "suspend.target";
  };
}
