{ pkgs, ... }:{
  systemd.user.services."startup_apps" = {
      Unit = {
        Description = "Launche desktop applications at Hyprland startup";
        After       = [ "hyprland-session.target"  ];
        PartOf      = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.alacritty}/bin/alacritty &";
        Restart   = "no";
      };
      Install.WantedBy = [ "hyprland-session.target" ];
    };
  };
}
