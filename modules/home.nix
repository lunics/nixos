{ config, ... }:{
  home = {
    username        = "${config._.username}";
    homeDirectory   = "/home/${config._.username}";
    stateVersion    = "24.05";
    enableDebugInfo = false;
    preferXdgDirectories      = true;     # make programs use XDG directories whenever supported
    enableNixpkgsReleaseCheck = true;

    # scripts blocks to run when running a Home Manager generation
    # If the script block produces any observable side effect, such as writing or deleting files, then it must be placed after the special writeBoundary
    # activation = {            
    #   myActivationAction = lib.hm.dag.entryAfter ["writeBoundary"] ''
    #     run ln -s $VERBOSE_ARG \
    #         ${builtins.toPath ./link-me-directly} $HOME
    #   '';
    # }

    # extraDependencies =                 # list of paths that should be included in the home closure but generally not visible
    # profileDirectory =                  # profile directory where Home Manager generations are installed
    #   "${home.homeDirectory}/.nix-profile"
    #     or
    #   "/etc/profiles/per-user/${home.username}"
  };
}
