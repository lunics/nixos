{ programs.ssh = {

enable = true;

matchBlocks = {
  "***REMOVED***" = {
    hostname     = "***REMOVED***";
    user         = "lunics";
    identityFile = "/home/lunics/.ssh/homelab";
  };
};

};}
