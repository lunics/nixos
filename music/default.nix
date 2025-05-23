{ pkgs, ... }:{ 
  home.packages = with pkgs; [
    mpd
    mpd-notification
    # mpd-mpris
    # mpd-discord-rpc

    musescore

    # ardour                # ko build: raptor
    jack2
    helm                    # free polyphonic synth with lots of modulation
    # yabridge              # to use Windows VST2, VST3 and CLAP plugins on Linux
    # reaper
    # bitwig
    
    # - xjadeo              # simple video player that is synchronized to jack transport
    # - zita-njbridge       # Jack client to transmit audio over a local IP network
    # - cadence             # control panel for audio work
    # - harvid              # HTTP Ardour Video Daemon
    # - yabridge            # enable Windows VST2 and VST3 plugins on Linux
    # - yabridgectl
    # - helm-synth
    # - vital-synth
    # - surge               # Open Source Digital Synthesizer
    # - carla               # audio plugin host
  ];

  home.file = {
    ".config/MuseScore/MuseScore4.ini".source = ./MuseScore4.ini;
  };

  services.mpd = {
    enable  = true;
    startWhenNeeded = true;
    group   = "mpd";
    user    = "mpd";
    musicDirectory = "${home.homeDirectory}/music";

    dataDir = "$XDG_DATA_HOME/mpd";
    dbFile  = "\${dataDir}/tag_cache";   # MPD's database
    playlistDirectory = "\${dataDir}/playlists";
    # extraConfig "";
    # extraArgs = [];
    fluidsynth = false;     # add fluidsynth soundfont and configure the plugin
  };

  programs.rmpc.enable = true;
  # file.".config/rmpc/config.ron".source = ./config.ron;
}
