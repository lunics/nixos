{
  flake.aspects.multiplexer.homeManager = { pkgs, ... }:{
    # tmux config can't be reloaded without exiting the current session, because pointing the older home-manager symlink
    programs.tmux = {
      enable       = true;
      prefix       = "C-a";             # Ctrl + a as prefix key
      terminal     = "tmux-256color";   # $TERM, tmux-256color, screen-256color, xterm-256color
      historyLimit = 100000;
      clock24      = true;
      baseIndex    = 1;
      keyMode      = "vi";
      mouse        = true;
    };
  };
}
