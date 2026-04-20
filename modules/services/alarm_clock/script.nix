{ config, lib, pkgs, ... }:{
    nixpkgs.overlays = [
      (self: super: {
        alarm-clock = super.writeScriptBin "alarm-clock" ''
          #!${pkgs.nushell}/bin/nu

          print "Test print"
          # hyprctl dispatch dpms on

          ${pkgs.mpv}/bin/mpv --really-quiet ${./bird_forest.mp3}
        '';
      })
    ];
}
