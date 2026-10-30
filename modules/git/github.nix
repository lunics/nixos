{
  flake.aspects.git.homeManager = { config, pkgs, ... }:{
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

    # path of the shared clan var github-token
    home.sessionVariables."GITHUB_TOKEN" = "$(cat /run/secrets/vars/shared/github-token/token 2>/dev/null)";
  };
}
