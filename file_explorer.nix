{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".config/yazi" = {
    source    = ./files/yazi;
    recursive = true;
  };
}
