{ programs.ssh = {

enable = true;

matchBlocks = {
  "Host ***REMOVED***" = {
    hostname     = "***REMOVED***";
    user         = "lunics";
    identityFile = "/home/lunics/.ssh/homelab";
  };
  # "Host host2" = {
  #   hostname = "host2.example.com";
  #   user = "user2";
  #   identityFile = "/home/user2/.ssh/id_rsa_host2";
  #   port = 22;
  # };
};

};}
