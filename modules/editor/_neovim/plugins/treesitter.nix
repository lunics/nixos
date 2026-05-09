{ pkgs, ... }:{
  plugins.treesitter = {
    enable           = true;
    highlight.enable = true;
    indent.enable    = true;
    # folding.enable   = false;
    
    opts = {
      foldenable     = false; # Permet quand même d'utiliser les commandes zo/zc si besoin
      foldlevel      = 99;    # Tout est ouvert par défaut (car le niveau est très haut)
      foldlevelstart = 99;
    };

    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      lua
      python
      javascript
      bash
      json
      make
      markdown
      nix
      regex
      toml
      vim
      vimdoc
      xml
      yaml
    ];
  };
}
