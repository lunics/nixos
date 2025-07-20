{ pkgs, ... }:{
  home.packages = with pkgs; [
    git-filter-repo     # rewrite git repository history
  ];

  programs = {
    git = {
      enable      = true;
      userName    = "lunics";
      userEmail   = "***REMOVED***";
      extraConfig = {
        init.defaultBranch = "main"; 
      }; 
    };

    # conflictstyle = zdiff3 ??
  };

  home.sessionVariables = {
    GIT_CONFIG_GLOBAL = "$HOME/.config/git/config";
    GIT_AUTHOR_NAME   = "lunics";
    GIT_AUTHOR_EMAIL  = "***REMOVED***";
  };
}

# [core]
# pager = delta

# [interactive]
# diffFilter = delta --color-only

# [delta]
# navigate = true  # use n and N to move between diff sections
# dark = true      # or light = true, or omit for auto-detection
# side-by-side = true
# line-numbers = true

# [merge]
