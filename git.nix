{ pkgs, ... }:{ programs = {

  git = {
    enable      = true;
    package     = pkgs.git;
    userName    = "Lunics";
    userEmail   = "git@***REMOVED***";
    extraConfig = {
      init.defaultBranch = "main"; }; };

  gh = {
    enable  = true;
    package = pkgs.gh;
    settings.git_protocol = "ssh"; }; };

  # home.sessionVariables = {
  #   GIT_CONFIG_GLOBAL = "$CONFIG/git/gitconfig";
  #   GIT_AUTHOR_NAME   = "Lunics";
  #   GIT_AUTHOR_EMAIL  = "git@***REMOVED***";
  #   GH_TOKEN          = "{{ github_token }}"; };

}
