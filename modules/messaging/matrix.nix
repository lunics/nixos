{
  flake.aspects.messaging.homeManager = { config, pkgs, lib, ... }:{ 
    config = lib.mkIf config._.matrix {
      home.packages = with pkgs; [
        element-desktop
        # matrix-dl         # download backlogs from Matrix as raw text
        # matrix-hook       # webhook for matrix
      ];
    };
  };
}
