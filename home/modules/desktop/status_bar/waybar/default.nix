{ config, lib, ... }:{
  config = lib.mkIf (config._.status_bar == "waybar") {
    programs.waybar.enable = true;

    xdg.configFile = {
      "waybar" = {
        source    = ./v2;
        recursive = true;
      };
    };
  };
}
