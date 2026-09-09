{
  flake.aspects.multiplexer.homeManager = {
    programs.herdr = {
      enable = true;

      settings = {
        onboarding = false;

        terminal = {
          default_shell = "zsh";
          shell_mode    = "auto";
          new_cwd       = "follow";   # open new panes in the current pane directory
        };

        ui = {
          sidebar_width    = 32;
          agent_panel_sort = "priority";
          sound.enabled    = false;
        };

        keys.prefix = "ctrl+a";       # same prefix as tmux
      };
    };
  };
}
