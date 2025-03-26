{
  programs.atuin = {
    enable   = true;
    settings = {
      db_path        = "$HOME/usb_copy/homelab/share/atuin/history.db";
      inline_height  = 25;
      invert         = false;
      search_mode    = "fuzzy";     # fuzzy, skim, prefix, fulltext
      style          = "compact";
      enter_accept   = true;        # enter execute immediately, tab to edit command
      secrets_filter = true;   };
    # flags = ["--disable-up-arrow"]; 
  };
}
