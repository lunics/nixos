{
  flake.aspects.music.homeManager = { config, lib, pkgs, ... }:{
    multiverse.pins.carla = "2.5.9";    # interconnect MIDI apps, and host plugins    ## newer revisions fail to build

    home.packages = with pkgs; [
      pamixer
      pavucontrol
      ## ncpamixer ?
      jack2               # JACK audio connection kit, version 2 with jackdbus
    ];

    # home.activation.musicDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    #   mkdir -p ${config._.home}/music
    # '';
  };
}
