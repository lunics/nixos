{ pkgs, ... }:{

programs.alacritty = {
  enable   = true;
  package  = pkgs.alacritty;
  settings = {
    window.opacity = 0.7;
    env.TERM = "xterm-256color";
    font.size = 21.0;
    # terminal_font_family: Hack    # Hack, monospace
  };
};

}
