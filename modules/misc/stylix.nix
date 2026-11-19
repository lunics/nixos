{ inputs, ... }:{ 
  flake-file.inputs.stylix = {
    url = "github:danth/stylix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.stylix.homeManager = { config, lib, pkgs, ... }:{
    imports = [ inputs.stylix.homeModules.stylix ];

    stylix = {
      enable          = true;
      # defaults to autoEnable, refused as a nixos submodule
      overlays.enable = lib.mkIf config.submoduleSupport.enable false;
      base16Scheme    = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      # image         = ./wallpaper.png;
      polarity        = "dark";    # light

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

        sizes.terminal = 22;
      };

      opacity.terminal = 0.7;

      cursor = {
        name    = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size    = 15;
      };
    };
  };
}
