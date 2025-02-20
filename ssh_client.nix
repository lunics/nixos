{
  programs.ssh = {
    enable     = true;
    matchBlocks = {
      "***REMOVED***" = {
        user         = "lunics";
        identityFile = "/home/lunics/.ssh/yubikey"; };
      "github.com" = {
        user         = "lunics";
        identityFile = "/home/lunics/.ssh/yubikey"; };
    };

    # extraConfig = ''
    #   AddKeysToAgent yes
    
    #   Host gitlab.com
    #     UpdateHostKeys no
    # '';

    # knownHosts."name".publicKey = 
    # enableAskPassword = true;
    # askPassword = "${pkgs.gnome.seahorse}/libexec/seahorse/ssh-askpass";
  };
}
