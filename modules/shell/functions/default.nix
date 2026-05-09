{
  flake.aspects.functions.homeManager = {
    home.file = {
      ".local/functions" = {
        source     = ./files;
        recursive  = true; };
    };
  };
}
