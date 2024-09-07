{ pkgs, ... }:{

programs.atuin = {
  enable = true;
  package  = pkgs.atuin;
  settings = {
    db_path        = "$SHARE/atuin/history.db";
    inline_height  = 25;
    invert         = true;
    search_mode    = "fuzzy";     # fuzzy, skim, prefix, fulltext
    style          = "compact";
    enter_accept   = true;        # enter execute immediately, tab to edit command
    secrets_filter = true;   };

  flags = ["--disable-up-arrow"]; };

}
