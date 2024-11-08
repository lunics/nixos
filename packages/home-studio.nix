{ pkgs, ... }:{ home.packages = with pkgs; [

musescore
ardour
jack2

# - xjadeo             # simple video player that is synchronized to jack transport
# - zita-njbridge      # Jack client to transmit audio over a local IP network
# - cadence            # control panel for audio work
# - harvid             # HTTP Ardour Video Daemon
# - yabridge           # enable Windows VST2 and VST3 plugins on Linux
# - yabridgectl
# - helm-synth
# - vital-synth
# - surge              # Open Source Digital Synthesizer
# - carla              # audio plugin host

] ;}
