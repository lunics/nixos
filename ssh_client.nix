{
  programs.ssh = {
    enable      = true;
    matchBlocks = {
      "***REMOVED***" = {
        user         = "lunics";
        identityFile = "/home/lunics/.ssh/yubikey"; 
      };
      "github.com" = {
        user         = "lunics";
        identityFile = "/home/lunics/.ssh/yubikey";
      };
      "elitedesk-800g2" = {
        user         = "lunics";
        identityFile = "/home/lunics/.ssh/servers";
        hostname     = "192.168.1.35";
      };
      "thinkpad-t14" = {
        user         = "root";
        identityFile = "/home/lunics/.ssh/servers";
        hostname     = "192.168.1.35";
      };
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
