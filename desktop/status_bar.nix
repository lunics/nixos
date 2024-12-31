{ pkgs, ... }:{

  programs.waybar = {
    enable  = true;
    package = pkgs.waybar; };

  xdg.configFile = {
    "waybar" = {
      source    = ../files/waybar/v2;
      recursive = true;
    };
  };
}
