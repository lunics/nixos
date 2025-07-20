{
  programs.gh = {
    enable   = true;
    settings = {
      git_protocol = "ssh"; 
      editor       = "nvim";
      # alias      = {}
    }; 
    # extensions = [];
  };

  ## home.sessionVariables."GH_TOKEN" = "{{ github_token }}"; 
}
