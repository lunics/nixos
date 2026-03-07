{ config, lib, pkgs, ... }:{
  config = lib.mkIf (config._.screen_locker == "swaylock") {
    programs.swaylock = {
      enable   = true;
      package  = pkgs.swaylock-effects;
      settings = {
        daemonize             = true;
        screenshots           = true;
        ignore-empty-password = true;
        effect-blur           = "7x5";
        effect-vignette       = "0.5:0.5";
        #effect-greyscale     = true;
        #effect-scale         = 0.3;
        fade-in               = 0.2;
        grace                 = 0;
        indicator             = true;
        indicator-radius      = 100;
        indicator-thickness   = 6;
        indicator-caps-lock   = true;
        inside-color          = "00000000";
        clock                 = false;
      };
    };
  };
}
