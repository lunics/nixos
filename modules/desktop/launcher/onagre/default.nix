{
  flake.aspects.launcher.homeManager = {
    programs.onagre = {
      enable = true;
      style = builtins.readFile ./theme.scss;
    };
  };
}
