{ config, pkgs, ... }:{
  programs.tmux.plugins = with pkgs.tmuxPlugins; [ {
    plugin = tmux-sessionx;
    extraConfig = ''
      set -g @sessionx-prefix on               #  bind '<mykey>' with the tmux '<prefix>'
      # set -g @sessionx-bind 's'               
      bind -n M-s run-shell -b "${pkgs.tmuxPlugins.tmux-sessionx}/share/tmux-plugins/sessionx/scripts/sessionx.sh";
      set -g @sessionx-x-path "${config._.share}/tmux"
      set -g @sessionx-fzf-builtin-tmux 'true'    # Uses fzf --tmux instead of fzf-tmux
      set -g @sessionx-filter-current 'true'      # the current session will not be shown on first view
      set -g @sessionx-window-mode 'true'         # all the windows listed rather than sessions only
      set -g @sessionx-tree-mode 'true'           # replace the preview by a hierarchy of sessions and windows
      set -g @sessionx-preview-enabled 'true'
      set -g @sessionx-zoxide-mode 'true'         # a non-result will be sent to zoxide for path matching
      # set -g @sessionx-window-height '80%'
      # set -g @sessionx-window-width '80%'
      # set -g @sessionx-prompt "ea:"
      # set -g @sessionx-pointer "▶ "
    '';
  } ];
}
