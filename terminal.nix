{ pkgs, ... }:{

programs.alacritty = {
  enable   = true;
  package  = pkgs.alacritty;
  settings = {
    window.opacity = 0.7;
    env.TERM = "xterm-256color";
    font.size = 22.0;
    selection = {
      semantic_escape_chars = '',│`|:"' ()[]{}<>'';
      save_to_clipboard = true;
    };

    live_config_reload = true;

    scrolling = {
      history = 10000;
      multiplier = 3;
    };

    # terminal_font_family: Hack    # Hack, monospace

    shell = {
      program = "tmux";
      # args = [
      #   "-A"
      #   "-D"
      # ];
    };

    window = {
      decorations = "none";
      dynamic_title = false;
      dynamic_padding = true;
      dimensions = {
        columns = 170;
        lines = 45;
      };
      padding = {
        x = 5;
        y = 1;
      };
    };

  };
};

}
