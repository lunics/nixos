{
  flake.aspects.reaper.homeManager = { pkgs, ... }:{
    _.persistent-home.dirs = [ ".config/REAPER" ];    # settings, license, reapack packages

    _.allow-unfree = with pkgs; [
      reaper                      # best linux DAW not too expensive
    ];

    home.packages = with pkgs; [
      reaper-reapack-extension    # package manager for reaper
      reaper-sws-extension        # reaper Plugin Extension
    ];
  };
}
