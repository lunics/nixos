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
      TMUX_FZF_PREVIEW=0
      TMUX_FZF_OPTIONS="-p -w 30%"
      TMUX_FZF_WINDOW_FORMAT=""

      set -ag terminal-overrides ",xterm-256color:RGB"
      # set -g terminal-overrides "xterm*:smcup@:rmcup@"

      # reload config
      bind r source-file ~/.config/tmux/tmux.conf

      set -g pane-base-index 1

      # allow passthrough
      set-option -g allow-passthrough

      # Set border colors
      set -g pane-border-lines heavy

      # copy mode key binds
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
      bind P paste-buffer
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy"

      # set title
      set -g set-titles on
      set -g set-titles-string "#H:#S.#I.#P #W #T"

      # status bar
      set -g allow-rename off               # don't allow ssh or ranger to rename window name
      set -g status-position top
      set -g status-justify left
      set -g status-interval 4              # ?
      set -g status-left ""                                     # disable the left status
      set -g status-right ""                                    # disable the right status
      set -g status-style bg=default                            # transparent status bar
      set -g window-status-separator ""
      set -g window-status-style          " bg=black fg=white bold"  # colour232
      set -g window-status-format         " #W "
      set -g window-status-current-style  " bg=black bold"         # current window background
      set -g window-status-current-format " #[fg=lime]#W "         # current window font
      set -g monitor-activity off           # disable window activity background color
        ## ajouter #F après #W pour afficher le précédent tab utilisé
    '';
  };

  # # aliases
  # home.shellAliases = {
  #   tnew  = "tmux new -s";
  #   ta    = "tmux attach -t";
  #   tdetach = "tmux detach";
  #   tkill = "tmux kill-session -t";
  #   tlist = "tmux ls";
  # };
  #
  # # copy over scripts
  # home.file.".config/tmux/scripts" = {
  #   recursive = true;
  #   source = ./scripts;
  # };
}
