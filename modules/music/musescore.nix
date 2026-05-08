{ config, lib, pkgs, ... }:
let
  version = "4";
in {
  home = {
    packages = with pkgs; [ 
      musescore
      muse-sounds-manager
    ];

    activation.link_musescore_share = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ln -s ${config._.musescore.share} ${config._.local_share} &> /dev/null || true
    '';
  };

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
}
