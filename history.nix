{ pkgs, ... }:{

programs.atuin = {
  enable = true;
  package  = pkgs.atuin;
  settings = {
    inline_height  = 25;
    invert         = true;
    search_mode    = "skim";
    style          = "compact";
    secrets_filter = true;   };

  flags = ["--disable-up-arrow"]; };

}
