{
  flake.aspects.desktop.homeManager = {
    qt = {
      enable        = true;
      style         = "adwaita-dark";
      platformTheme = "gnome";
      kde.settings  = {};
    };
  };
}
