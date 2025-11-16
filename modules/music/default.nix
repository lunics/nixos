{ config, lib, pkgs, ... }:{
  imports = [
    ./mpd.nix
    ./rmpc
    ./musescore.nix
    ./home_studio
  ];

  home.packages = with pkgs; [
    pamixer
    pavucontrol
    ## ncpamixer ?
    jack2               # JACK audio connection kit, version 2 with jackdbus
    carla               # interconnect MIDI apps, and host plugins
  ];

  # create music directory
  home.activation.musicDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${config.home.homeDirectory}/music"
  '';
}
