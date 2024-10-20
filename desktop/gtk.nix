{ pkgs, ... }:{

gtk = {
  enable = true;

  theme = {
    name    = "Adwaita-dark";
    package = pkgs.gnome-themes-extra; };

  # catppuccin = {
  #   enable = true;
  #   gnomeShellTheme = true; };
  # iconTheme = {
  #   name = "Tela-circle-dark";
  #   package = pkgs.tela-circle-icon-theme; };
  # cursorTheme = {
  #   name = "Yaru";
  #   package = pkgs.yaru-theme; };
  # font = {
  #   name = "Roboto";
  #   size = 11; };
  # gtk3.bookmarks = [
  #   "file:///home/nabokikh/Downloads/temp"
  #   "file:///home/nabokikh/Documents/repositories" ];

};
}
