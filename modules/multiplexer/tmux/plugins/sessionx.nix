{ pkgs, ... }:{
  programs.tmux.plugins = with pkgs.tmuxPlugins; [ {
    plugin = tmux-sessionx;
    extraConfig = ''
      set -g @sessionx-prefix off               #  bind '<mykey>' without the tmux '<prefix>'
      set -g @sessionx-bind 's'
      set -g @sessionx-x-path '$HOME/usb_copy/homelab/share/tmux'
      set -g @sessionx-fzf-builtin-tmux 'on'    # Uses `fzf --tmux` instead of the `fzf-tmux`
      set -g @sessionx-filter-current 'on'      # the current session will not be shown on first view
      # set -g @sessionx-window-mode 'off'        # all the windows listed rather than sessions only
      # set -g @sessionx-tree-mode 'off'          # replace the preview by a hierarchy of sessions and windows
      # set -g @sessionx-preview-enabled 'on'
      # set -g @sessionx-window-height '80%'
      # set -g @sessionx-window-width '80%'
      # set -g @sessionx-prompt "ea:"
      # set -g @sessionx-pointer "▶ "
    '';
  } ];
}
