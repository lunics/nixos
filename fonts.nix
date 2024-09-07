{ fonts = {

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
];

enableDefaultPackages = true;

}; }
