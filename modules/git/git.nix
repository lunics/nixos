{ config, pkgs, ... }:{
  home.packages = with pkgs; [
    git-filter-repo     # rewrite git repository history
  ];

  programs.git = {
    enable       = true;
    # hooks = {     # default hooks used when git clone
    #   pre-commit = ./pre-commit-script;
    # };
    settings = {
      user = {
        name  = "lunics";
        email = "***REMOVED***";
      };
      init.defaultBranch = "main"; 
      # user.signingkey = lib.mkIf (builtins.hasAttr osConfig.networking.hostName signingKeys) (signingKeys.${osConfig.networking.hostName});
      # fetch.writeCommitGraph = true;
      # core.fsmonitor = true;
      # ghq = {
      #   root = "~/dev";
      # };
      # push.autoSetupRemote = true;
    }; 
    ignores = [
      ".direnv"
    ];
    # conflictstyle = zdiff3 ??
  };

  programs.delta = {
    enable               = true;       # delta syntax highlighter
    enableGitIntegration = true;
  };

  home.sessionVariables = {
    GIT_CONFIG_GLOBAL = "${config._.dot_config}/git/config";
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
