{ config, ... }:{ 
  programs.zsh = {
    history = {
      path          = "${config._.share}/zsh/history";  # require a path, can't be empty for disabling zsh history
      size          = 0;              # 10000 (default), history lines to keep
      save          = 0;              # 10000 (default), history lines to save
      share         = true;           # share command history between zsh sessions
      ignoreSpace   = true;           # do not record command into the history if the first character is a space
      ignorePatterns = [              # do not record command into the history if they match patterns
        # "rm *" "pkill *"
      ];
      append        = false;          # zsh sessions will append their history list to the history file, rather than replace it
      extended      = false;          # save timestamp into the history file
      expireDuplicatesFirst = false;
      saveNoDups    = false;
      ignoreDups    = true;           # do not record if duplicates
      ignoreAllDups = true;           # the older duplicated command will be replaced by the new one
      findNoDups    = false;
    };

    historySubstringSearch = {
      enable        = false;
      searchDownKey = [ "^[[B" ];     # DOWN key
      searchUpKey   = [ "^[[A" ];     # UP key
    };
  };
}
