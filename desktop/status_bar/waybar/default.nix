{
  programs.waybar.enable = true;

  xdg.configFile = {
    "waybar" = {
      source    = ./v2;
      recursive = true;
    };
  };
}
