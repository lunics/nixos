{
  flake.aspects.qt.homeManager = {
    qt = {
      enable        = true;
      style         = "adwaita-dark";
      platformTheme = "gnome";
      kde.settings  = {};
    };
  };
}
