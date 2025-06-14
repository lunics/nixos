{
  home.file.".config/systemd/user/startup_apps.service".text = ''
    [Unit]
    After=hyprland.target
    Description=Launch desktop applications at Hyprland startup
    PartOf=hyprland.target

    [Service]
    ExecStart=/run/current-system/sw/bin/hyprctl dispatch exec mullvad-vpn
    ExecStart=/run/current-system/sw/bin/hyprctl dispatch exec alacritty
    ExecStart=/run/current-system/sw/bin/hyprctl dispatch exec zen-twilight
    ExecStart=/run/current-system/sw/bin/hyprctl dispatch exec udiskie
    Restart=on-failure
    Type=oneshot
    
    [Install]
    WantedBy=hyprland.target
  '';
}
