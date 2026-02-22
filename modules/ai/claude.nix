{ config, pkgs, ... }:{ 
  home.packages = with pkgs; [ 
    # open-interpreter  # KO build pygame
    claude-code
    # claude-monitor      # real-time Claude Code usage monitor
    # claude-code-router  # to route Claude Code requests to different models and customize any request
  ];
}
