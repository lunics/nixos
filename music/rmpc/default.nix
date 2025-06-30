{
  programs.rmpc = {
    enable = true;
    config = builtins.readFile ./rmpc;
  }

  home.file.".config/rmpc/theme.ron".source = ./theme.ron;
}
