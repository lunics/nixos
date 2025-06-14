# tmux config can't be reloaded without exiting the current session, because pointing the older home-manager symlink
{ pkgs, ... }:{
  programs.tmux = {
    enable       = true;
    prefix       = "C-a";             # Ctrl + a as prefix key
    terminal     = "tmux-256color";   # $TERM, tmux-256color, screen-256color, xterm-256color
    historyLimit = 100000;
    clock24      = true;
    baseIndex    = 1;
    keyMode      = "vi";
    mouse        = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      copycat
      better-mouse-mode
      extrakto            # manage clipboard into tmux
      fuzzback            # fzf search in scrollback mode
      urlview

      # session-wizard
      # sessionist

      # tilish            i3 motion like
      # jump
      # pass

      # powerline
      # power             pourquoi pas l'intégrer en version allégée
      # loggin            Easy logging and screen capturing for Tmux
      # mode-indicator    displays prompt current active Tmux mode
      # tmux-prefix-highlight

      # tmux-update-display KO
      # tmux-autoreload
      # tmux-sensible

      # yank
      # vim-tmux-navigator
      # pain-control
      # open
      # tmux-thumbs

    ];

    extraConfig = ''
      ${ builtins.readFile ./options    }
      ${ builtins.readFile ./status_bar }
    '';
  };

  imports = [
    # (import ./binds.nix { inherit pkgs custom-tmux-fzf; })
    ./binds.nix
    ./plugins/tmux-fzf.nix
    ./plugins/floax.nix
    ./plugins/resurrect.nix
    ./plugins/sessionx.nix
  ];

  # programs.cron = {
  #   enable = true;
  #   crontab = ''
  #     # Example: Run a script every day at 3:30 AM
  #     30 3 * * * /home/your-username/.config/scripts/your-script.sh
  #   '';
  # };
}
