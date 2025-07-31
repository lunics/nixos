{ pkgs, custom-tmux-fzf, ... }:{
  programs.tmux.extraConfig = ''
    unbind '"'      # unbind horizontal split
    unbind %        # unbind vertical split
    
    bind -n M-Space last                # go to last tab/window
    # bind Space list-panes   # replace by fzf
    bind Enter break-pane     # ???
    
    bind -n M-a command-prompt "rename-window %%"
    bind -n M-d detach-client
    bind -n M-h prev                    # go to prev tab/window
    bind -n M-l next                    # go to next tab/window
    bind -n M-j swap-pane -D \; select-pane -U
    bind -n M-q kill-window             # close window
    # bind -n F4 run-shell -b "tmux display-popup -E \"tmux lsw -F '#{window_index} #{window_name}' | fzf | cut -c 1-1 | xargs tmux select-window -t\""
    bind -n M-m copy-mode               # enter in copy mode to scroll and use visual vi mode
    bind -n M-n new-window
    bind -n M-p command-prompt "joinp -t:%%" # %% = prompt for window.pane [-V|H] # vert|hor split  ???
    #bind R refresh-client              # Redraw the client (if interrupted by wall, etc) ??
    # bind -n M-r run-shell -b "$CONFIG/tmux/plugins/tmux-resurrect/scripts/restore.sh"
    bind r source $HOME/.config/tmux/tmux.conf\; display "tmux config reloaded"
    # bind -n M-s run-shell -b "$CONFIG/tmux/plugins/tmux-fzf/scripts/session.sh switch"  KO
    # bind -n M-s display-popup -E 'source ~/home-manager/charles/sh/functions/tmux.sh; __switch_session'
    # bind -n M-S-s display-popup -E 'source ~/home-manager/charles/sh/functions/tmux.sh; __new_session'
    # bind -n M-Tab display-popup -E 'source ~/home-manager/charles/sh/functions/tmux.sh; __switch_window'
    # bind -n M-z split-window -h -c "#{pane_current_cwd}" -l 14\# split pane vertically in current directory
    bind -n M-z split-window -v -c "#{pane_current_cwd}" -l 18% \; swap-pane -D # split pane horizontally in current directory and keed focus the origin
    
    # bind C-j previous-window  KO
    # bind C-k next-window      KO
    # bind t choose-tree -w -O time         # list windows by date
    
    ## all M-S-* are KO
    # bind -n M-S-h select-pane -L
    # bind -n M-S-j select-pane -D
    # bind -n M-S-k select-pane -U
    # bind -n M-S-l select-pane -R
    # bind -n M-S-r source-file $HOME/.config/tmux/tmux.conf \; display "tmux config reloaded"
    # bind -n M-S-s set-option status       # toggle status bar
    
    bind -n M-C-h swap-window -t -1\; select-window -t -1
    bind -n M-C-l swap-window -t +1\; select-window -t +1
    bind -n M-C-j resize-pane -D
    bind -n M-C-k resize-pane -U
    bind -n M-C-s run-shell -b "${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/save.sh";
    # bind -n M-C-? resize-pane -L
    # bind -n M-C-? resize-pane -R
    
    # copy mode key binds
    bind -T copy-mode-vi v send -X begin-selection
    bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
    bind P  paste-buffer
    bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy"
  '';
}
