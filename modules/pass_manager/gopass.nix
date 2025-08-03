{ pkgs, ... }:{
  home = {
    packages = with pkgs; [ 
      gopass
      gopass-jsonapi
      # git-credential-gopass     # to cache your git-credentials with gopass
    ];

    file.".config/gopass/config".source = ./gopass_config;
  };
}
