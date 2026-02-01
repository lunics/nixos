{ config, pkgs, ... }: {
  systemd = {
    timers."nixos-auto-upgrade" = {
      description = "auto upgrade nixos every friday at 20:00 pm";
      unitConfig = {
        OnCalendar = "Fri *-*-* 20:00:00";
        Persistent = true;
        Unit       = "nixos-auto-upgrade.service";
      };
      wantedBy = [ "timers.target" ];
    };

    services."nixos-auto-upgrade" = {
      description = "nixos auto upgrade";
      wants       = [ "network-online.target" ];
      after       = [ "network-online.target" ];
      serviceConfig = {
        Type         = "oneshot";
        ExecStartPre = [
          "${pkgs.systemd}/bin/systemctl --user --machine=${config._.user}@.host start flake-update.service"
        ];
        ExecStart = [ 
          "${pkgs.nixos-auto-upgrade}/bin/nixos-auto-upgrade"
        ];
        ExecStartPost = [
          "${pkgs.systemd}/bin/systemctl --user --machine=${config._.user}@.host start home-manager-auto-upgrade.service"
        ];
      };
    };
  };
}
