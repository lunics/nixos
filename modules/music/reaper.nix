{ pkgs, ... }:{ 
  home.packages = with pkgs; [
    # reaper                      # best linux DAW not too expensive
      ## KO /nix/store/jrw7q6v8q74hhv43zgpq7i4jmxj9nwlj-stdenv-linux/setup: line 1758: ./install-reaper.sh: Permission denied
    reaper-reapack-extension    # package manager for reaper
    reaper-sws-extension        # reaper Plugin Extension
  ];
}
