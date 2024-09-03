{ pkgs, userSettings, ... }: { programs = {

  git = {
    enable     = true;
    package    = pkgs.gitFull;
    userName   = userSettings.gitname;
    userEmail  = userSettings.gitemail;
    signing.key = userSettings.gpgkey;
    signing.signByDefault = true;
    extraConfig = {
      color.ui = true;
      # verbose messages
      commit.verbose = true;
      # always rebase when pulling
      pull.rebase = true;
    };
    lfs.enable = true; # git lfs for large files
    diff-so-fancy.enable = true;

  };
  gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };
};
}
