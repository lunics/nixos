{ pkgs, userSettings, ... }: { programs = {

  git = {
    enable     = true;
    userName   = "Lunics";
    userEmail  = "git@***REMOVED***";

    # extraConfig = {
    #   color.ui = true;
    #   commit.verbose = true;
    #   pull.rebase = true;
    # };
  };

  gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };
};
}
