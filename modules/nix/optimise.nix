{
  nix.optimise = {
    automatic  = false;         # run the nix store optimiser at a specific time
    persistent = true;          # make the systemd timer persistent, to avoid running after the date if missed
    dates      = [ "03:45" ];   # format: https://www.mankier.com/7/systemd.time
    randomizedDelaySec = "0";   # randomized delay before the optimizer will run
  };
}
