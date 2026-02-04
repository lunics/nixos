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
      ln -s ${config._.musescore_share} ${config._.local_share} &> /dev/null || true
    '';
  };

  xdg.configFile."MuseScore/MuseScore4.ini".text = ''
    [application]
    hasCompletedFirstLaunchSetup=true
    paths\lastOpenedProjectsPath=/home/${config._.user}/
    paths\myPlugins=${config._.musescore_share}/MuseScore${version}/Plugins
    paths\myScores=${config._.musescore_share}/MuseScore${version}/Scores
    paths\mySoundfonts=${config._.musescore_share}/MuseScore${version}/SoundFonts
    paths\myStyles=${config._.musescore_share}/MuseScore${version}/Styles
    paths\myTemplates=${config._.musescore_share}/MuseScore${version}/Templates
    
    [cloud]
    clientId=${config._.musescore_client_id}
  '';
}
