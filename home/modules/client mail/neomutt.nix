{ pkgs, ... }:{ 
  programs.neomutt = {
    enable   = true;
    package  = pkgs.neomutt;
    settings = {};
    vimKeys  = true;
    editor   = "$EDITOR";
    sort     = "threads";
    sourcePrimaryAccount = true;
    checkStatsInterval   = 300;   # every 5 mins
    changeFolderWhenSourcingAccount = true;


    sidebar = {
      enable    = true;
      width     = 22;
      shortPath = true;     # only show the relative path of the mailbox
      format    = "%D%?F? [%F]?%* %?N?%N/?%S";
    };

    unmailboxes = false;    # set unmailboxes * at the start of account configurations
    extraConfig = "";
    binds       = [];       # keybindings
    macros      = [];
  };
}
