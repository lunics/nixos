{
  programs = {
    git = {
      enable      = true;
      userName    = "lunics";
      userEmail   = "git@***REMOVED***";
      extraConfig = {
        init.defaultBranch = "main"; }; 
    };

    gh = {
      enable   = true;
      # extensions = [];
      settings = {
        git_protocol = "ssh"; 
        editor       = "nvim";
        # alias      = {}
      }; 
    };

    # xdg.configFile."lazygit/config.yml".text = builtins.readFile ./files/lazygit.yml;
    # lazygit = {
    #   enable  = true;
    #   package = pkgs.lazygit;
    #   settings = {};
    # };
  };

  home.sessionVariables = {
    GIT_CONFIG_GLOBAL = "$HOME/.config/git/config";
    GIT_AUTHOR_NAME   = "lunics";
    GIT_AUTHOR_EMAIL  = "git@***REMOVED***";
    # GH_TOKEN        = "{{ github_token }}"; 
  };
}
