{ pkgs, ... }:{ 
  home.packages = with pkgs; [
    reaper                      # best linux DAW not too expensive
    reaper-reapack-extension    # package manager for reaper
    reaper-sws-extension        # reaper Plugin Extension
  ];
}
