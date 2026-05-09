{
  flake.aspects.music.homeManager = { config, lib, pkgs, ... }:{
    home.packages = with pkgs; [
      pamixer
      pavucontrol
      ## ncpamixer ?
      jack2               # JACK audio connection kit, version 2 with jackdbus
      carla               # interconnect MIDI apps, and host plugins
    ];

    # home.activation.musicDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    #   mkdir -p ${config._.home}/music
    # '';
  };
}
