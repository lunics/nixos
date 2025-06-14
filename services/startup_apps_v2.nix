{
  home.file.".config/systemd/user/startup_apps.service".text = ''
    [Install]
    WantedBy=hyprland.target
    
    [Service]
    ExecStart=hyprctl dispatch exec mullvad-vpn
    ExecStart=hyprctl dispatch exec alacritty
    ExecStart=hyprctl dispatch exec zen-twilight
    ExecStart=hyprctl dispatch exec udiskie
    Restart=on-failure
    Type=oneshot
    
    [Unit]
    After=hyprland.target
    Description=Launch desktop applications at Hyprland startup
    PartOf=hyprland.target
  '';
}
