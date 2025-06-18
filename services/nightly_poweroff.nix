{
  systemd = {
    timers."nightly-task" = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "23:00";
      };
    };

    services."nightly_poweroff" = {
      description = "Poweroff laptop every night at 23:00 pm";
      serviceConfig = {
        Type      = "oneshot";
        ExecStart = "/home/lunics/.nix-profile/bin/dunstify -t 5000 'Poweroff in 10 minutes'";
        ExecStart = "/run/current-system/sw/bin/sleep 300";
        ExecStart = "/home/lunics/.nix-profile/bin/dunstify -t 5000 'Poweroff in 5 minutes'";
        ExecStart = "/run/current-system/sw/bin/sleep 300";
        ExecStart = "/home/lunics/.nix-profile/bin/poweroff";
      };
    };
  };
}
