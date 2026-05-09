{ pkgs, ... }:{
  systemd.user = {
    timers."wallpaper" = {
      Unit.Description = "wallpaper.timer triggered every hour";
      Timer = {
        OnCalendar  = "*-*-* 00..23:00";
        AccuracySec = "1s";
        Persistent  = false;        # don't change wallpaper if scheduling missed
      };
      Install.WantedBy  = [ "default.target" ];
    };

    services."wallpaper" = {
      Unit = {
        Description = "update wallpaper";
        # PartOf      = [ "hyprland.target" ];    ## trigger server at every hm build
        # After       = [ "hyprland.target" ];    ## trigger server at every hm build
      };

      Service = {
        Type      = "oneshot";
        ExecStart = "${pkgs.update-wallpaper}/bin/update-wallpaper";
      };

      # Install.WantedBy = [ "hyprland.target" ];   # restart wallpaper at every home-manager build
    };
  };
}
