{ config, pkgs, ... }:{ 
  programs.fabric-ai = {
    enable                = true;
    package               = pkgs.fabric-ai;
    enableYtAlias         = true;
    enableZshIntegration  = config.programs.zsh.enable;
    enableBashIntegration = false;
    enablePatternsAliases = false;
  };
}
