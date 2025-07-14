{ pkgs, ... }:{
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif      = [ "Liberation Serif" "Vazirmatn" ];
        sansSerif  = [ "Ubuntu" "Vazirmatn" ];
        monospace  = [ "Ubuntu Mono" ];  };
    };
    packages = with pkgs; [
      ubuntu_font_family
      liberation_ttf
      vazir-fonts
      nerd-fonts.fira-code    
      nerd-fonts.droid-sans-mono
      # nerd-fonts._0xproto
    ];
  };
}
