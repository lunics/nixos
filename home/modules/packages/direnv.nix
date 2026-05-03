{ pkgs, ... }:{ 
  programs.direnv = {   # required by clan
    enable  = true;
    package = pkgs.direnv;
    enableZshIntegration = true;

    mise = {
      enable  = true;
      package = pkgs.mise;
    };
    nix-direnv = {
      enable  = false;
      package = pkgs.nix-direnv;
    };

    enableNushellIntegration = false;
    enableFishIntegration    = false;
    enableBashIntegration    = false;
    config = {};
    stdlib = "";
    silent = false;
  };
}
