{
  programs.nh = {
    enable = true;
    # flake  = "";          # set NH_OS_FLAKE
    clean = {
      enable    = false;    # enable periodic garbage collection for user profile and nix store with nh clean user
      dates     = "weekly";
      extraArgs = "";       # "--keep 5 --keep-since 3d"
    };
    # homeFlake = null      # NH_HOME_FLAKE is used by nh as the default flake for performing nh home
    # osFlake = null;       # NH_OS_FLAKE is used by nh as the default flake for performing nh os
    # package = pkgs.nh;
    # darwinFlake = null;
  };
}
