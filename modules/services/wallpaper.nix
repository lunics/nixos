{ pkgs, ... }:{
  home = {
    packages = with pkgs; [ 
      swww 
      coreutils   # for shuf to get a random value
    ];
    file.".config/systemd/user/wallpaper.sh".source = ./wallpaper.sh;
  };

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
        PartOf      = [ "hyprland.target" ];
        After       = [ "hyprland.target" ];
      };

      Service = {
        Type      = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash %h/.config/systemd/user/wallpaper.sh";
      };

      # Install.WantedBy = [ "hyprland.target" ];   # restart wallpaper at every home-manager build
    };
  };
}
