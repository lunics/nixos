{ pkgs, ... }:{
  home = {
    packages = with pkgs; [ 
      swww 
      coreutils   # to get shuf to pick a random wallpaper
    ];
    file.".config/systemd/user/wallpaper.sh".source = ./wallpaper.sh;
  };

  systemd.user = {
    # timers."wallpaper" = {
    #   Unit.Description = "Update wallpaper twice a day";
    #   Timer = {
    #     # OnBootSec       = "30s";
    #     # OnUnitActiveSec = "30min";    TODO
    #     AccuracySec     = "1s";
    #   };
    #   Install.WantedBy  = [ "default.target" ];
    # };

    services."wallpaper" = {
      Unit = {
        Description = "Sync browser profile between RAM and disk";
        PartOf = [ "hyprland.target" ];
        After  = [ "hyprland.target" ];
      };

      Service = {
        Type      = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash %h/.config/systemd/user/sync_browser_profile.sh %i";
      };

      Install.WantedBy = [ "hyprland.target" ];
    };
  };
}
