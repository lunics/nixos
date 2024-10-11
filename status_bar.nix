{...}: let
  waybar_config = ./../../files/configs/waybar;
in {
  programs.waybar = {
    enable  = true;
    package = pkgs.waybar;
  };

  # Source waybar config from the home-manager store
  xdg.configFile = {
    "waybar" = {
      source    = "${waybar_config}";
      recursive = true;
    };
  };
}
