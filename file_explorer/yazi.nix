{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".config/yazi" = {
    source    = ./yazi;
    recursive = true;
  };
}
