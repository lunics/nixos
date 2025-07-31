{ pkgs, ... }:{ 
  imports = [ stylix.homeModules.stylix ];

  stylix = {
    enable       = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    # image      = ./wallpaper.png;
    polarity     = "dark";    # light

    fonts = {
      serif = {
        name    = "DejaVu Serif";
        package = pkgs.dejavu_fonts;
      };

      sansSerif = {
        name    = "DejaVu Sans";
        package = pkgs.dejavu_fonts;
      };

      monospace = {
        name    = "DejaVu Sans Mono";
        package = pkgs.dejavu_fonts;
      };

      emoji = {
        name    = "Noto Color Emoji";
        package = pkgs.noto-fonts-emoji;
      };
    };

    cursor = {
      name    = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size    = 15;
    };
  };
}
