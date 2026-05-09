{
  flake.aspects.ai.homeManager = { config, pkgs, ... }:{ 
    programs.fabric-ai = {
      enable                = false;
      package               = pkgs.fabric-ai;
      enableYtAlias         = true;
      enableZshIntegration  = config.programs.zsh.enable;
      enableBashIntegration = false;
      enablePatternsAliases = false;
    };
  };
}
