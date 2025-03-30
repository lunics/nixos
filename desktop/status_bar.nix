{
  programs.waybar.enable = true;

  xdg.configFile = {
    "waybar" = {
      source    = ../files/waybar/v2;
      recursive = true;
    };
  };
}
