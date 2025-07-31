{ pkgs, inputs, ... }:{
  systemd.user = {
    targets."hyprland".Unit.Description = "Hyprland Session Target";
  };

  home.file.".config/systemd/user/startup_apps.service".text = ''
    [Unit]
    Description=Launch desktop applications at Hyprland startup
    PartOf=hyprland.target
    After=hyprland.target
    Requires=sync_browser_profile@lunics.service
    After=sync_browser_profile@lunics.service

    [Service]
    Type=oneshot
    Restart=on-failure
    ExecStart=/run/current-system/sw/bin/hyprctl dispatch exec mullvad-vpn
    ExecStart=/run/current-system/sw/bin/hyprctl dispatch exec alacritty
    ExecStart=/run/current-system/sw/bin/hyprctl dispatch exec zen
    ExecStart=/run/current-system/sw/bin/hyprctl dispatch exec udiskie
    ExecStart=/run/current-system/sw/bin/hyprctl dispatch exec swww-daemon
    
    [Install]
    WantedBy=hyprland.target
  '';
}
    ## home-manager restart this service at every rebuild
    # services."startup_apps" = {
    #   Unit = {
    #     Description = "Launch desktop applications at Hyprland startup";
    #     After       = [ "hyprland.target"  ];
    #     PartOf      = [ "hyprland.target" ];
    #   };
    #   Service = {
    #     Type = "oneshot";
    #     ExecStart = [ 
    #       # "/bin/sh -c '${pkgs.alacritty}/bin/alacritty &'"    # KO maybe run inside a subshell never displayed
    #       # "${pkgs.alacritty}/bin/alacritty"                   # KO lock the others execstart
    #       "${pkgs.hyprland}/bin/hyprctl dispatch exec mullvad-vpn"
    #       "${pkgs.hyprland}/bin/hyprctl dispatch exec alacritty"
    #       "${pkgs.hyprland}/bin/hyprctl dispatch exec zen-twilight"
    #       "${pkgs.hyprland}/bin/hyprctl dispatch exec udiskie"
    #     ];
    #     Restart   = "on-failure";
    #   };
    #   Install.WantedBy = [ "hyprland.target" ];
    # };
