{ pkgs, ... }: {
  systemd.user = {
    timers."home-manager-auto-upgrade" = {
      Install.WantedBy = [ "timers.target" ];
      Timer = {
        OnCalendar = "Fri *-*-* 21:00:00";
        Persistent = true;
        Unit       = "home-manager-auto-upgrade.service";
      };
      Unit.Description = "auto upgrade home manager every friday at 21:00 pm";
    };

    services."home-manager-auto-upgrade" = {
      Unit = {
        Description = "home manager upgrade";
        Requires    = "flake-update.service";
        After       = "flake-update.service";
      };

      Service = {
        Type      = "oneshot";
        ExecStart = [ 
          "${pkgs.home-manager-auto-upgrade}/bin/home-manager-auto-upgrade"
        ];
      };
    };
  };
}

