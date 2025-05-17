{ pkgs, ... }:{

# home.packages = with pkgs; [
#   # tmux            # depends on screen for working
#   # tmuxp           # tmuxinator like en plus pratique ?
#   # # tmuxinator    # (aur) no more needed with tmux-resurrect plugin
#   # entr            # tmux-autoreload plugin dependence
#   # python-libtmux  # for tmux-window-name plugin
#   # git             # to clone the repos of tmux plugins
#   # tmux-sessionizer    # cli tool to fuzzy find all git repositories in a list of specified folders and open them as a new tmux session
# ];

  programs.tmux = {
    enable       = true;
    package      = pkgs.tmux;
    prefix       = "C-a";             # Ctrl + a as prefix key
    terminal     = "tmux-256color";   # $TERM, tmux-256color, screen-256color, xterm-256color
    historyLimit = 100000;
    clock24      = true;
    baseIndex    = 1;
    keyMode      = "vi";
    mouse        = true;

    plugins = with pkgs.tmuxPlugins; [
      tmux-fzf
      # tmux-update-display KO
      # tmux-autoreload
      # tmux-sensible
      sensible

      # yank
      # vim-tmux-navigator
      # copycat
      # pain-control
      # sessionist
      # open
      # tmux-thumbs

      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim "session"
          set -g @resurrect-save          "S"
          set -g @resurrect-restore       "R"
          # set -g @resurrect-dir         "$HOME/cloud/linux/share/tmux_sessions"   # only $HOME and ~ are enabled
          set -g @resurrect-capture-pane-contents "on"
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore       'on'
          set -g @continuum-save-interval '30'  # save session every N minutes
        '';
      }
    ];

    extraConfig = ''
      ${ builtins.readFile ./tmux/options    }
      ${ builtins.readFile ./tmux/status_bar }
      ${ builtins.readFile ./tmux/binds      }
    '';
  };

  # programs.screen = {
  #   enable   = true;
  #   package  = pkgs.screen;
  #   screenrc = ''
  #     termcapinfo xterm* ti@:te@
  #     defscrollback 1000000
  #     shell -$SHELL
  #     autodetach on
  #     startup_message off
  #     hardstatus off
  #     hardstatus alwayslastline
  #     hardstatus string '%{= kG}[ %{G}%H %{g}][%= %{= kw}%?%-Lw%?%{r}(%{W}%n*%f%t%?(%u)%?%{r})%{w}%?%+Lw%?%?%= %{g}][%{B} %d-%m-%y %{W} %c %{g}]'
  #     wrap on
  #   '';
  # };

  # # aliases
  # home.shellAliases = {
  #   tnew  = "tmux new -s";
  #   ta    = "tmux attach -t";
  #   tdetach = "tmux detach";
  #   tkill = "tmux kill-session -t";
  #   tlist = "tmux ls";
  # };

  # # copy over scripts
  # home.file.".config/tmux/scripts" = {
  #   recursive = true;
  #   source = ./scripts;
  # };
}
