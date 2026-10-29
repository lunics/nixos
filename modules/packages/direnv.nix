{
  flake.aspects.packages.homeManager = { config, ... }:{
    _.persistent-home.dirs = [ ".local/share/direnv" ];    # allowed .envrc list

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
