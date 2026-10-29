{
  flake.aspects.musescore.homeManager = { config, pkgs, ... }: let
    version = "4";
  in {
    home = {
      packages = with pkgs; [ 
        musescore
        muse-sounds-manager
      ];
    };

    _.persistent-home.dirs = [
      ".local/share/MuseScore"     # scores, plugins, soundfonts, cloud login
      ".local/share/MuseSampler"   # instruments installed by muse-sounds-manager
    ];

    xdg.configFile."MuseScore/MuseScore4.ini".text = ''
      [application]
      hasCompletedFirstLaunchSetup=true
      paths\lastOpenedProjectsPath=${config._.musescore.projects_path}
      paths\myPlugins=${config._.musescore.share}/MuseScore${version}/Plugins
      paths\myScores=${config._.musescore.share}/MuseScore${version}/Scores
      paths\mySoundfonts=${config._.musescore.share}/MuseScore${version}/SoundFonts
      paths\myStyles=${config._.musescore.share}/MuseScore${version}/Styles
      paths\myTemplates=${config._.musescore.share}/MuseScore${version}/Templates
      welcomeDialogLastShownIndex=0
      welcomeDialogLastShownVersion=4.6.5.
      welcomeDialogShowOnStartup=false

      [cloud]
      clientId=${config._.musescore.client_id}
    '';
  };
}
