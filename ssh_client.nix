{ programs.ssh = {

enable = true;

matchBlocks = {
  "***REMOVED***"    = {
    user         = "lunics";
    identityFile = "/home/lunics/.ssh/homelab";
  };
};

}; }
