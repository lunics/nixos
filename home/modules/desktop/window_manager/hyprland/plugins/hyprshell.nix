{ config, pkgs, ... }:{
  services.hyprshell = {
    enable  = true;
    package = pkgs.hyprshell;

    settings = {
      windows = {
        scale = 8.0;
        overview = {
          launcher = {
            max_items = 6;
          };
        };
        switch = {
          modifier = "alt";
        };
      };
    };

    style = "";
    
    systemd = {
      enable = true;
      target = config.wayland.systemd.target;
      args = "";
    };
  };
}
