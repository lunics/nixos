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
        init.defaultBranch = "main"; }; 
    };

    gh = {
      enable   = true;
      settings = {
        git_protocol = "ssh"; 
        editor       = "nvim";
        # alias      = {}
      }; 
      # extensions = [];
    };

    lazygit = {
      enable  = true;
      settings = {
        git.autoFetch = false
      };
    };
  };

  home.sessionVariables = {
    GIT_CONFIG_GLOBAL = "$HOME/.config/git/config";
    GIT_AUTHOR_NAME   = "lunics";
    GIT_AUTHOR_EMAIL  = "***REMOVED***";
    # GH_TOKEN        = "{{ github_token }}"; 
  };
}
