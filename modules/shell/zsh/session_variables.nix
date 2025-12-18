{
  programs.zsh.sessionVariables = rec {
    WORDCHARS   = "*?_-[]~=&;!#$%^(){}<>";  # special characters considered as normal letters
    # KEYTIMEOUT  = 0.1;                      # time to activate vim mode and others mode, ## tester sans
    # ZSH_FZF_HISTORY_SEARCH_BIND = "^r";     # set keybinding for zsh-fzf-history-search plugin
    # CASE_SENSITIVE:     "true"
    # HYPHEN_INSENSITIVE: "true"          # Case-sensitive completion must be off. _ and - will be interchangeable
    # DISABLE_AUTO_TITLE: "true"          # auto-setting terminal title
    # ENABLE_CORRECTION:  "true"          # command auto-correction
  };
}
