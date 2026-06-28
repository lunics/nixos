{
  flake.aspects.editor.homeManager = { config, lib, pkgs, ... }:{
    config = lib.mkIf config._.libreoffice {
      home.packages = with pkgs; [
        libreoffice
      ];
    };
  };
}
