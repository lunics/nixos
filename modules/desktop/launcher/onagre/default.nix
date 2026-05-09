{
  flake.aspects.onagre.homeManager = {
    programs.onagre = {
      enable = true;
      style = builtins.readFile ./theme.scss;
    };
  };
}
