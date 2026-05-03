{ config, lib, pkgs, ... }:{
  imports = [
    ./reaper.nix
  ];

  config = lib.mkIf config._.home_studio {
    home.packages = with pkgs; [
      yabridge            # to use Windows VST2, VST3 and CLAP plugins on Linux
      yabridgectl         # small, optional utility to help set up and update yabridge for several directories at once

      # synthesizer
      dexed               # DX7 FM multi platform/multi format plugin
      helm                # free polyphonic synth with lots of modulation
      surge               # open source digital synthesizer

      # bitwig            # ableton linux, native linux but very expensive 400€
      # ardour            # ko build: raptor
      # harvid            # HTTP Ardour Video Daemon
      # xjadeo            # simple video player that is synchronized to jack transport
      # zita-njbridge     # Jack client to transmit audio over a local IP network
      # cadence           # control panel for audio work
      # vital-synth
    ];
  };
}
