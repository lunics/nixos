{ pkgs, ... }:{

  programs.waybar = {
    enable  = true;
    package = pkgs.waybar;
  };

  xdg.configFile = {
    "waybar" = {
      source    = ../files/waybar/lunics;
      recursive = true;
    };
  };
}
