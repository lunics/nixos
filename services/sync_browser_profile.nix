{ pkgs, ... }:{
  systemd.user = {
    timers."sync_browser_profile" = {
      Unit.Description = "Sync browser profile at boot, and every 30 min";
      Timer = {
        OnBootSec       = "30s";
        OnUnitActiveSec = "30min";
        AccuracySec     = "1s";
      };
      Install.WantedBy  = [ "default.target" ];
    };

    services."sync_browser_profile" = {
      Unit.Description = "Sync Zen-twilight profile in memory cache";

      Service = {
        Type      = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash %h/.config/systemd/user/sync_browser_profile.sh";
        ExecStop  = "${pkgs.bash}/bin/bash %h/.config/systemd/user/sync_browser_profile.sh";
        RemainAfterExit = "yes";
      };

      Install.WantedBy = [ "default.target" ];
    };
  };

  home.file.".config/systemd/user/sync_browser_profile.sh".source = ./sync_browser_profile.sh;
}
