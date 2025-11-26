{
  programs.zsh = {
    # todo
    #   https://github.com/romkatv/zsh4humans
    #   https://github.com/jeffreytse/zsh-vi-mode
    
    enable   = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      styles = {
        comment = "fg=grey,bold";
      };
      # pacakge = pkgs.zsh-syntax-highlighting;
      # highlighters = [
      #   "brackets"
      # ];
      # patterns = {
      #   "rm -rf *" = "fg=white,bold,bg=red";
      # }
    };
    
    initContent = ''
      for file in $HOME/.local/functions/*; do
        source $file
      done

      for file in $HOME/.local/functions/zsh/*; do
        source $file
      done
    
      ${builtins.readFile ./bindkeys.zsh }
    '';
    
    # zplug = {
    #   enable = true;
    #   plugins = [
    #     # { name = "zsh-users/zsh-autosuggestions";   }
    #     # { name = "marlonrichert/zsh-autocomplete";  }
    #     # { name = "zdharma-continuum/fast-syntax-highlighting"; }
    #     # { name = "olets/zsh-abbr"; tags = ["at:82fc2b53d7b1c2df60fdea6f13701cff9c536197"]; }
    #   ];
    # };
  }; 

  home.sessionVariables = rec {
    # ZSH
    # ZSHRC       = "$SHELLRC/zsh";           # personnal
    # ZDOTDIR     = "$ZSHRC";                 # official
    # # ZSH_THEME = "robbyrussell";
    WORDCHARS   = "*?_-[]~=&;!#$%^(){}<>";    # special characters considered as normal letters
    # KEYTIMEOUT  = 0.1;                      # time to activate vim mode and others mode, ## tester sans
    # ZPLUG_HOME  = "$ZSHRC/zplug";           # zplug home dir
    # ZSH_FZF_HISTORY_SEARCH_BIND = "^r";     # set keybinding for zsh-fzf-history-search plugin
    # CASE_SENSITIVE:     "true"
    # HYPHEN_INSENSITIVE: "true"          # Case-sensitive completion must be off. _ and - will be interchangeable
    # DISABLE_AUTO_TITLE: "true"          # auto-setting terminal title
    # ENABLE_CORRECTION:  "true"          # command auto-correction
  };

  home.file = {
    ".local/functions/zsh" = {
      source     = ./functions;
      recursive  = true; };
  };
}
