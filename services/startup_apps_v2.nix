{
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
    ExecStart=/run/current-system/sw/bin/hyprctl dispatch exec swww-daemon --quiet
    
    [Install]
    WantedBy=hyprland.target
  '';
}
