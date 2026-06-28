{
  flake.aspects.packages.homeManager = { config, ... }:{ 
    programs.direnv = {   # required by clan
      enable  = true;
      enableZshIntegration = true;

      mise = {
        enable  = config._.mise;
      };
      nix-direnv = {
        enable  = false;
      };

      enableNushellIntegration = false;
      enableFishIntegration    = false;
      enableBashIntegration    = false;
      config = {};
      stdlib = "";
      silent = false;
    };
  };
}
