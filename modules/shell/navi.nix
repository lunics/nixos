{
  flake.aspects.navi.homeManager = { config, ... }:{
    programs.navi = {
      enable = true;
      enableZshIntegration = false;   # the widget is loaded by bindkeys.zsh, to rebind it afterwards
      settings = {
        cheats.paths     = [ "${config._.share}/navi" ];  # list of dirs containing all *.cheat files
        client.tealdeer  = true;                          # use tldr pages as an extra cheatsheet source
        finder.command   = "fzf";
        shell.command    = "zsh";
        style = {
          tag     = { color = "blue";  width_percentage = 15; };
          comment = { color = "green"; width_percentage = 35; };
          snippet = { color = "white"; width_percentage = 50; };
        };
      };
    };
  };
}
