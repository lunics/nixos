{ 
  programs.ssh = {
    enable = true;
    
    matchBlocks = {
      "***REMOVED***" = {
        user         = "lunics";
        identityFile = "/home/***REMOVED***/.ssh/homelab"; };
    };
  };

# startAgent = true;
# enableAskPassword = true;
# askPassword = "${pkgs.gnome.seahorse}/libexec/seahorse/ssh-askpass";
# extraConfig = ''
#   AddKeysToAgent yes
#
#   Host gitlab.com
#     UpdateHostKeys no
# '';

}
