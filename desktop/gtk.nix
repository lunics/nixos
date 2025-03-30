{ pkgs, ... }:{ gtk = {
  enable = true;

  theme = {
    name    = "Adwaita-dark";
    package = pkgs.gnome-themes-extra; };   # Adwaita, 

  ## try Yaru / pkgs.yaru-theme
  cursorTheme = {
    name    = "Vanilla-DMZ";              # name of the cursor theme
    package = pkgs.vanilla-dmz;           # package providing the cursor theme
    size    = 16; };

  font = {
    name    = "DejaVu Sans";
    package = pkgs.dejavu_fonts;
    size    = 11; };

  # iconTheme = {
  #   name = "Tela-circle-dark";
  #   package = pkgs.tela-circle-icon-theme; };

  # gtk2 = {
  #   configLocation = "${config.home.homeDirectory}/.gtkrc-2.0";
  #   extraConfig    = "gtk-can-change-accels = 1"; };

  # gtk3 = {
  #   extraConfig = {
  #     gtk-cursor-blink = false;
  #     gtk-recent-files-limit = 20; };
  #   extraCss = "";
  #   bookmarks = [
  #     "file:///home/nabokikh/Downloads/temp"
  #     "file:///home/nabokikh/Documents/repositories" ];
  # };

  # gtk4 = {
  #   extraConfig = {};
  #   extraCss = "";
  # };

}; }
