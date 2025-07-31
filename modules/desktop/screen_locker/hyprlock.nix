{ pkgs, ... }:{ 
  programs.swaylock = {
    enable   = true;
    package  = pkgs.swaylock-effects;
    settings = {
      daemonize = true;
      screenshots = true;
      indicator = true;
      indicator-radius = 100;
      indicator-thickness = 8;
      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";
      inside-color = "00000000";
      grace = 0;
      fade-in = 0.0;
    };
  };
}
