{
  home.file.".config/systemd/user/startup_apps.service".text = ''
    [Unit]
    Description=Launch desktop applications at Hyprland startup
    PartOf=hyprland.target
    After=hyprland.target

    [Service]
    Type=oneshot
    Restart=on-failure
    ExecStart=/run/current-system/sw/bin/hyprctl dispatch exec mullvad-vpn
    ExecStart=/run/current-system/sw/bin/hyprctl dispatch exec alacritty
    ExecStart=/run/current-system/sw/bin/hyprctl dispatch exec zen-twilight
    ExecStart=/run/current-system/sw/bin/hyprctl dispatch exec udiskie
    
    [Install]
    WantedBy=hyprland.target
  '';
}
