{
  programs.lazygit = {
    enable  = true;
    settings = {
      git.autoFetch = false;
      disableStartupPopups = true;
      # reporting = "off";
      # startupPopupVersion = 1;
    };
  };
}
