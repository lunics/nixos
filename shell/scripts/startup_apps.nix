{ pkgs }: pkgs.writeShellApplication {
  name = "gen_pass";
  runtimeInputs = with pkgs; [ 
    alacritty 
    firefox   
    freetube  
    spotify   
    discord   
    udiskie   
  ];
  text = ''
    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    
    alacritty &
    firefox   &
    freetube  &
    spotify   &
    discord   &
    udiskie   &
  '';
}
