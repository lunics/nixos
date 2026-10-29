{
  flake.aspects.editor.homeManager = { config, lib, pkgs, ... }:{
    config = lib.mkIf config._.libreoffice {
      _.persistent-home.dirs = [ ".config/libreoffice" ];

      home.packages = with pkgs; [
        libreoffice
      ];
    };
  };
}
