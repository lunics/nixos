{ config, ... }:{
  programs.ssh = {
    enable               = true;
    package              = null;
    extraConfig          = "";
    extraOptionOverrides = {};
    includes             = [];      # File globs of ssh config files
    matchBlocks          = config._.ssh_config;

    enableDefaultConfig  = false;   ## if true see below
    ## MOVE IN matchBlocks
    #   addKeysToAgent       = "no";
    #   userKnownHostsFile   = "~/.ssh/known_hosts";
    #   serverAliveInterval  = 0;
    #   serverAliveCountMax  = 3;
    #   hashKnownHosts       = false;       # ssh should hash host names and addresses when they are added to the known hosts file
    #   forwardAgent         = false;
    #   compression          = false;
    #   controlMaster        = "no";         # yes, no, ask, auto, autoask; Configure sharing of multiple sessions over a single network connection
    #   controlPath          = "~/.ssh/master-%r@%n:%p";   # path to the control socket used for connection sharing
    #   controlPersist       = "no";        # control socket should remain open in the background
  };
}
