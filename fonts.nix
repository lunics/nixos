{ pkgs, ... }:{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif      = [ "Liberation Serif" "Vazirmatn" ];
      sansSerif  = [ "Ubuntu" "Vazirmatn" ];
      monospace  = [ "Ubuntu Mono" ];  };
  };

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    ubuntu_font_family
    liberation_ttf
    vazir-fonts
  ];
}
