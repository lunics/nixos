{ config, ... }:{
  programs.gh = {
    enable   = true;
    # gitCredentialHelper.enable = true;
    settings = {
      git_protocol = "ssh"; 
      editor       = "nvim";
      # alias      = {}
    }; 
    # extensions = [];
  };

  home.sessionVariables."GITHUB_TOKEN" = config._.github_token; 
}
