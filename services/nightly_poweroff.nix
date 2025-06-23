{
  systemd.user = {
    timers."nightly_poweroff" = {
      Unit.Description = "Poweroff laptop every night at 23:00 pm";
      Timer = {
        OnCalendar = "22:50";
        Persistent = true;
      };
      Install.WantedBy = [ "default.target" ];
    };

    services."nightly_poweroff" = {
      Unit.Description = "Poweroff laptop once nightly_poweroff.timer is triggered";
      Service = {
        Type      = "oneshot";
        ExecStart = [ 
          "/home/lunics/.nix-profile/bin/dunstify -t 5000 'Poweroff in 10 minutes'"
          "/run/current-system/sw/bin/sleep 300"
          "/home/lunics/.nix-profile/bin/dunstify -t 10000 'Poweroff in 5 minutes'"
          "/run/current-system/sw/bin/sleep 300"
          "/home/lunics/.nix-profile/bin/poweroff"
        ];
      };
    };
  };
}
