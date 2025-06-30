{ pkgs, ... }:{ 
  home = {
    packages = with pkgs; [ musescore ];
    file.".config/MuseScore/MuseScore4.ini".source = ./MuseScore4.ini;
  };
}
