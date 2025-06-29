{ pkgs, ... }:{ 
  imports = [
    ./mpd.nix
    ./musescore.nix
  ];

  home.packages = with pkgs; [
    ardour                  # ko build: raptor
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

  programs.rmpc.enable = true;
  home.file.".config/rmpc" = {
    source = ./rmpc;
    recursive  = true;
  };
}
