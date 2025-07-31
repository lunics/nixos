{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".config/yazi/yazi.toml" = {
    source    = ./yazi.toml;
    # recursive = true;
  };
}
