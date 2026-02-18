{ config, pkgs, ... }:{
  programs.gh = {
    enable   = true;
    # gitCredentialHelper.enable = true;
    settings = {
      git_protocol = "ssh"; 
      editor       = config._.editor;
      # alias      = {}
    }; 
    # extensions = [];
  };

  # home.packages = with pkgs; [
  #   star-history    KO pending but never show chart on localhost:3000 or 8080
  # ];

  home.sessionVariables."GITHUB_TOKEN" = config._.github_token; 
}
