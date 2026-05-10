{
  flake.aspects.font_home.homeManager = ## enable on condition
  {
    fonts.fontconfig = {
      enable       = true;
      defaultFonts = {
        emoji      = [];
        serif      = [ "Liberation Serif" "Vazirmatn" ];
        sansSerif  = [ "Ubuntu" "Vazirmatn" ];
        monospace  = [ "Ubuntu Mono" ];  
      };
    };
  };
}
