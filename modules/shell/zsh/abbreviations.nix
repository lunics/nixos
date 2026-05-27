{
  flake.aspects.zsh.homeManager = { pkgs, ... }:{ 
    _.allow-unfree = with pkgs; [ zsh-abbr ];

    programs.zsh.zsh-abbr = {
      enable = true;
      # package = pkgs.zsh-abbr;
      abbreviations = {
        # gco = "git checkout";
        # l = "less";
      };
      globalAbbreviations = {
        # G = "| grep";
        # L = "| less -R";
      };
    };
  };
}
