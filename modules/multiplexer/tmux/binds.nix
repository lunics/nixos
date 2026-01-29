{ config, pkgs, custom-tmux-fzf, ... }:
let
  _tmux = config._.tmux;
in {
  programs.tmux.extraConfig = ''
    unbind '"'      # unbind horizontal split
    unbind %        # unbind vertical split
    unbind d        # unbind <prefix> + detache
    
    bind -n M-Space last                    # go to last tab/window
    # bind Space list-panes                 # replace by fzf
    bind Enter break-pane                   # ???
    
    bind -n M-a command-prompt "rename-window %%"
    # bind -n M-d detach-client             # disable detach capability
    # bind -n M-f                           # used by the floax plugin to run floated window
    bind -n M-${_tmux.prev_tab} prev        # go to prev tab/window
    bind -n M-${_tmux.next_tab} next        # go to next tab/window
    bind -n M-${_tmux.swap_pane_hori} swap-pane -D \; select-pane -U
    bind -n M-q kill-window                 # close the entire tab
    # bind -n F4 run-shell -b "tmux display-popup -E \"tmux lsw -F '#{window_index} #{window_name}' | fzf | cut -c 1-1 | xargs tmux select-window -t\""
    bind -n M-m copy-mode                   # enter in copy mode to scroll and use visual vi mode
    bind -n M-n new-window -a -c "$HOME"    # -c to change directory, -a append new window right after the current
    # bind -n M-p command-prompt "joinp -t:%%" # %% = prompt for window.pane [-V|H] # vert|hor split  ???
    #bind R refresh-client              # Redraw the client (if interrupted by wall, etc) ??
    bind r source $HOME/.config/tmux/tmux.conf\; display "tmux config reloaded"
    # bind -n M-s display-popup -E 'source ~/home-manager/charles/sh/functions/tmux.sh; __switch_session'
    # bind -n M-S-s display-popup -E 'source ~/home-manager/charles/sh/functions/tmux.sh; __new_session'
    # bind -n M-Tab display-popup -E 'source ~/home-manager/charles/sh/functions/tmux.sh; __switch_window'
    bind -n M-z split-window -v -c "#{pane_current_cwd}" -l 18% \; swap-pane -D # split pane horizontally in current directory and keed focus the origin
    
    # bind C-j previous-window  KO
    # bind C-k next-window      KO
    # bind t choose-tree -w -O time         # list windows by date
    
    ## all M-S-* are KO (because alacritty doesn't manage combo M-S) try on ghostty
    # bind -n M-S-h select-pane -L
    # bind -n M-S-j select-pane -D
    # bind -n M-S-k select-pane -U
    # bind -n M-S-l select-pane -R
    # bind -n M-S-r source-file $HOME/.config/tmux/tmux.conf \; display "tmux config reloaded"
    # bind -n M-S-s set-option status       # toggle status bar
    
    bind -n M-C-h   swap-window -t -1\; select-window -t -1
    bind -n M-C-l   swap-window -t +1\; select-window -t +1
    bind -n M-C-j   resize-pane -D
    bind -n M-C-k   resize-pane -U
    # bind -n M-C-s                           # used by tmux-resurrect to save session manually
    # bind -n M-C-? resize-pane -L
    # bind -n M-C-? resize-pane -R
    bind -n M-C-z   split-window -h -c "#{pane_current_cwd}" -l 14        # split pane vertically in current directory
    
    # copy mode key binds
    bind -T copy-mode-vi v send -X begin-selection
    bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
    bind P  paste-buffer
    bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy"
  '';
}
