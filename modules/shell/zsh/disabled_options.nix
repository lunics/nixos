{
  programs.zsh = {
    antidote.enable        = false;
    prezto.enable          = false;
    zprof.enable           = false;
    profileExtra           = "";
    logoutExtra            = "";
    loginExtra             = "";
    envExtra               = "";
    shellAliases         = {};
    shellGlobalAliases     = {};
    localVariables         = {};
    historySubstringSearch = {};
    cdpath                 = [];
    enableVteIntegration   = false;
    defaultKeymap          = null;   # emacs, vicmd viins
    siteFunctions = {      # functions added to the zsh environment and are subject to autoloading
      # mkcd = ''          # name of the function
      #   mkdir --parents "$1" &amp;&amp; cd "$1"     # body of the function
      # '';
    };
    setOptions = [
      # "HIST_IGNORE_DUPS"
      # "SHARE_HISTORY"
      # "HIST_FCNTL_LOCK"
      # "EXTENDED_HISTORY"
      # "RM_STAR_WAIT"
      # "NO_BEEP"                 # prefix it with NO_ to unset an option 
    ];
  };
}
