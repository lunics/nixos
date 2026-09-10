{
  flake.aspects.navi.homeManager = { config, pkgs, ... }:{
    programs.navi = {
      enable  = true;
      package = pkgs.navi;
      enableZshIntegration = true;
      settings = {
        cheats.paths     = [ "${config._.dot_config}/navi/cheats" ];
        client.tealdeer  = true;    # use tldr pages as an extra cheatsheet source
        finder.command   = "fzf";
        shell.command    = "zsh";

        style = {
          tag     = { color = "blue";  width_percentage = 20; };
          comment = { color = "green"; width_percentage = 45; };
          snippet = { color = "white"; width_percentage = 35; };
        };
      };
    };
  };
}
