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
      Unit.Description = "Update wallpaper every hour";
      Timer = {
        OnUnitActiveSec = "1h";
        AccuracySec     = "1s";
      };
      Install.WantedBy  = [ "default.target" ];
    };

    services."wallpaper" = {
      Unit = {
        Description = "Change wallpaper";
        PartOf = [ "hyprland.target" ];
        After  = [ "hyprland.target" ];
      };

      Service = {
        Type      = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash %h/.config/systemd/user/wallpaper.sh";
      };

      Install.WantedBy = [ "hyprland.target" ];
    };
  };
}
