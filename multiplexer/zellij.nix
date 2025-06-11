{
  programs.zellij = {
    enable = true;
    # attachExistingSession = true;       # require enableZshIntegration = true
    # enableZshIntegration  = true;
    settings = {
      on_force_close "quit"

      theme = "custom";
      themes.custom.fg = "#ffffff";
    };
    # themes = { 
    #   dracula { 
    #     ribbon_unselected {
    #       base 0 0 0
    #       background 255 153 0
    #       emphasis_0 255 53 94
    #       emphasis_1 255 255 255
    #       emphasis_2 0 217 227
    #       emphasis_3 255 0 255
    #     };
    #   };
    # };
  };
}
