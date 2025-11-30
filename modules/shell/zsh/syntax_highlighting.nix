{
  programs.zsh.syntaxHighlighting = {
    enable = true;
    # package = pkgs.zsh-syntax-highlighting;
    styles = {
      comment = "fg=grey,bold";
      alias   = "fg=magenta,bold";
    };
    patterns = {
      # "rm -rf *" = "fg=white,bold,bg=red";
    };

    # https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
    # main, brackets, pattern, cursor, regexp, root, line
    highlighters = [    
      "brackets"
      "pattern"
    ];
  };
} 
