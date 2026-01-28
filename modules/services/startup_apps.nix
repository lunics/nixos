{ config, pkgs, ... }:{
  systemd.user.services."startup_apps" = {
    Unit = {
      Description = "Launch desktop applications at Hyprland startup";
      PartOf      = [ "hyprland-session.target" ];
      After       = [ "hyprland-session.target" "sync_browser_profile@lunics.service" ];
      Requires    = [ "sync_browser_profile@lunics.service" ];
    };
    Service = {
      Type      = "oneshot";
      Restart   = "on-failure";
      ExecStart = map (program: "${pkgs.hyprland}/bin/hyprctl dispatch exec ${program}") config._.add_to_startup;
    };
    # Install.WantedBy = [ "hyprland-session.target" ];
  };
}
