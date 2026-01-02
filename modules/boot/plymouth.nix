{ config, pkgs, ... }:{ 
  config = lib.mkIf (config._.boot_splash == "plymouth") {
    boot.plymouth = {
      enable        = true;
      font          = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
        # "${pkgs.dejavu_fonts.minimal}/share/fonts/truetype/DejaVuSans.ttf";
      logo          = "${pkgs.nixos-icons}/share/icons/hicolor/48x48/apps/nix-snowflake-white.png";
      # logo          = pkgs.fetchurl {
      #   url = "https://nixos.org/logo/nixos-hires.png";
      #   sha256 = "1ivzgd7iz0i06y36p8m5w48fd8pjqwxhdaavc0pxs7w1g7mcy5si";
      # };
      theme         = "catppuccin-macchiato";                 # bgrt (default), breeze, catppuccin-macchiato
      themePackages = [ pkgs.catppuccin-plymouth ];
      extraConfig   = "";
    };
  };
}
