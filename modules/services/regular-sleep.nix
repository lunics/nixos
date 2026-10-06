{
  flake.aspects.regular-sleep.homeManager = { config, ... }:{
    systemd.user = {
      timers."regular-sleep" = {
        Unit.Description = "poweroff laptop every night at 23:00 pm";
        Timer = {
          OnCalendar = "22:50";
          Persistent = false;
        };
        Install.WantedBy = [ "default.target" ];
      };

      services."regular-sleep" = {
        Unit.Description = "poweroff laptop once regular-sleep.timer is triggered";
        Service = {
          Type      = "oneshot";
          ExecStart = [ 
            "${config._.home}/.nix-profile/bin/notify-send -t 5000 'Poweroff in 10 minutes'"
            "/run/current-system/sw/bin/sleep 300"
            "${config._.home}/.nix-profile/bin/notify-send -t 10000 'Poweroff in 5 minutes'"
            "/run/current-system/sw/bin/sleep 300"
            "${config._.home}/.nix-profile/bin/notify-send -t 10000 -u critical 'Poweroff in 10 seconds'"
            "/run/current-system/sw/bin/sleep 10"
            "/run/current-system/sw/bin/poweroff"
          ];
        };
      };
    };
  };
}
