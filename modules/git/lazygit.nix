{
  flake.aspects.git.homeManager = {
    _.persistent-home.dirs = [ ".local/state/lazygit" ];    # recent repositories

    programs.lazygit = {
      enable  = true;
      settings = {
        git.autoFetch = false;
        # git.commit.signOff = true;
        disableStartupPopups = true;
        # reporting = "off";
        # startupPopupVersion = 1;
      };
    };
  };
}
