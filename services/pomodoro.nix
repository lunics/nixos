{ pkgs, ... }:{
  systemd.user = {
    targets."suspend" = {
      Unit = {
        Description      = "User level suspend target";
        StopWhenUnneeded = true;
        Wants            = [ "pomodoro.service" ];
      };
    };

    services."pomodoro" = {
      Unit.Description  = "Pomodoro";
      Service.ExecStart = "${pkgs.bash}/bin/bash %h/.config/systemd/user/pomodoro.sh";
      Install.WantedBy  = [ "suspend.target" ];
    };
  };

  home.file.".config/systemd/user/pomodoro.sh".source = ./pomodoro.sh;
}
