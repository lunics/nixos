{
  flake.aspects.history.homeManager = {
    _.persistent-home.dirs = [ ".local/share/atuin" ];    # history database, sync key

    programs.atuin = {
      enable   = true;
      settings = {
        inline_height  = 25;
        invert         = false;
        search_mode    = "fuzzy";     # fuzzy, skim, prefix, fulltext
        style          = "compact";
        enter_accept   = true;        # enter execute immediately, tab to edit command
        secrets_filter = true;   };
      # flags = ["--disable-up-arrow"]; 
    };
  };
}
