{ config, pkgs, ... }:{
  programs.git = {
    enable       = true;
    # hooks = {     # default hooks used when git clone
    #   pre-commit = ./pre-commit-script;
    # };
    settings = {
      user = {
        name  = config._.git.user;
        email = config._.git.email;
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
    GIT_AUTHOR_NAME   = config._.git.user;
    GIT_AUTHOR_EMAIL  = config._.git.email;
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
