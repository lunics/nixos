{ config, inputs, pkgs, ... }:{
  home.file.".config/systemd/user/startup_apps.service".text = ''
    [Unit]
    Description=Launch desktop applications at Hyprland startup
    PartOf=hyprland-session.target
    After=hyprland-session.target
    Requires=sync_browser_profile@lunics.service
    After=sync_browser_profile@lunics.service

    [Service]
    Type=oneshot
    Restart=on-failure
    ExecStart=/run/current-system/sw/bin/hyprctl dispatch exec mullvad-vpn
    ExecStart=/run/current-system/sw/bin/hyprctl dispatch exec ${config._.terminal}
    # ExecStart=/run/current-system/sw/bin/hyprctl dispatch exec /home/lunics/.local/share/devbox/global/default/.devbox/nix/profile/default/bin/ghostty
    ExecStart=/run/current-system/sw/bin/hyprctl dispatch exec ${config._.browser}
    ExecStart=/run/current-system/sw/bin/hyprctl dispatch exec udiskie
    ExecStart=/run/current-system/sw/bin/hyprctl dispatch exec swww-daemon
    
    [Install]
    WantedBy=hyprland-session.target
  '';
}
    ## home-manager restart this service at every rebuild
    # services."startup_apps" = {
    #   Unit = {
    #     Description = "Launch desktop applications at Hyprland startup";
    #     After       = [ "hyprland-session.target"  ];
    #     PartOf      = [ "hyprland-session.target" ];
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
    #   Install.WantedBy = [ "hyprland-session.target" ];
    # };
