{ programs = {

  # TODO exports
  # GIT_CONFIG_GLOBAL: $CONFIG/git/gitconfig
  # GIT_AUTHOR_NAME:   lunics
  # GIT_AUTHOR_EMAIL:  contact@***REMOVED***
  # GH_TOKEN:          "{{ github_token }}"

  git = {
    enable      = true;
    userName    = "Lunics";
    userEmail   = "git@***REMOVED***";
    extraConfig = {
      init.defaultBranch = "main";
      # color.ui = true;
      # commit.verbose = true;
      # pull.rebase = true;
    };
  };

  gh = {
    enable = true;
    settings.git_protocol = "ssh";    # ssh, https
  };
};
}
