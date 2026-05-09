{
  flake.aspects.rmpc.homeManager = {
    programs.rmpc = {
      enable = true;
      config = builtins.readFile ./config.ron;
    };

    home.file.".config/rmpc/theme.ron".source = ./theme.ron;
  };
}
