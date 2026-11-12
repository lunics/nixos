{
  flake.aspects.font_home.homeManager = { config, lib, ... }: ## enable on condition
  {
    fonts.fontconfig = {
      enable       = true;                                           # adds the home-manager profile fonts to fontconfig, in every mode
      defaultFonts = lib.mkIf (!config.submoduleSupport.enable) {    # font_nixos sets them as a nixos submodule
        emoji      = [];
        serif      = [ "Liberation Serif" "Vazirmatn" ];
        sansSerif  = [ "Ubuntu" "Vazirmatn" ];
        monospace  = [ "Ubuntu Mono" ];
      };
    };
  };
}
