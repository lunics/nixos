{
  programs.waybar.enable = true;

  xdg.configFile = {
    "waybar" = {
      source    = ./waybar/v2;
      recursive = true;
    };
  };
}
