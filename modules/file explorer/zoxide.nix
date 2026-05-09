{
  flake.aspects.file_explorer.homeManager = { config, pkgs, ... }:{ 
    home.packages = with pkgs; [
      zoxide
    ];

    programs.zsh.sessionVariables._ZO_DATA_DIR = "${config._.share}/zoxide";
  };
}
