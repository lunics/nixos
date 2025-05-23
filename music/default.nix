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
    network = {
      startWhenNeeded = true;
      listenAddress = "127.0.0.1";
      port = 6600;
    };
    musicDirectory = "$HOME/music";
    ## KO is not of type 'absolute path'
      # dataDir = "$XDG_DATA_HOME/mpd";
      # dbFile  = "$XDG_DATA_HOME/mpd/tag_cache";   # MPD's database
      # playlistDirectory = "$XDG_DATA_HOME/mpd/playlists";
    # extraConfig "";
    # extraArgs = [];
  };

  programs.rmpc.enable = true;
  home.file.".config/rmpc" = {
    source = ./rmpc;
    recursive  = true;
  };
}
