{ pkgs, ... }:{ home.packages = with pkgs; [

musescore
# ardour                  # ko build: raptor
jack2
helm                    # free polyphonic synth with lots of modulation
# yabridge
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

] ;}
