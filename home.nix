{
  home = {
    username        = "lunics";
    homeDirectory   = "/home/lunics";
    stateVersion    = "24.05";
    enableDebugInfo = false;
    preferXdgDirectories      = true;     # make programs use XDG directories whenever supported
    enableNixpkgsReleaseCheck = true;
    # extraDependencies =                 # list of paths that should be included in the home closure but generally not visible
    # profileDirectory =                  # profile directory where Home Manager generations are installed
    #   "${home.homeDirectory}/.nix-profile"
    #     or
    #   "/etc/profiles/per-user/${home.username}"
  };
}
