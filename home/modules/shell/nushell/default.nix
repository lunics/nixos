{ config, pkgs, ... }:{ 
  programs.nushell = {
    enable               = true;
    package              = pkgs.nushell;
    configDir            = "${config.xdg.configHome}/nushell";
    settings             = {};
    shellAliases         = {};
    environmentVariables = {};
    extraLogin           = "";
    extraEnv             = "";
    extraConfig          = "";
    configFile           = null;
    loginFile            = null;
    envFile              = null;
  };

  imports = [
    # ./plugins.nix KO
  ];
}
