{ lib, ... }:{
  wayland.windowManager.hyprland.systemd = {
    enable    = true;     # enable hyprland-session.target on hyprland startup to import env var list below 
    variables = [         # env var to be imported in the systemd & D-Bus user environment
      # needed for firefox screen sharing under wayland and other utilities
      # "DISPLAY"
      # "HYPRLAND_INSTANCE_SIGNATURE"
      # "WAYLAND_DISPLAY"
      # "XDG_CURRENT_DESKTOP"
      "--all"
    ];
    enableXdgAutostart = false;
    extraCommands = [             # extra commands to be run after D-Bus activation
      "systemctl --user stop hyprland-session.target"
      "systemctl --user start hyprland-session.target"
    ];
  };
}
