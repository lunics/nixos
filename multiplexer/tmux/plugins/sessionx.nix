{ pkgs, ... }:{
  programs.tmux.plugins = with pkgs.tmuxPlugins; [ {
    plugin = sessionx;
    extraConfig = ''
      set -g @sessionx-prefix off               #  bind '<mykey>' without the tmux '<prefix>'
      set -g @sessionx-bind '<M-s>'      
      set -g @sessionx-x-path '/home/lunics/usb_copy/homelab/share/tmux'
      set -g @sessionx-fzf-builtin-tmux 'on'    # Uses `fzf --tmux` instead of the `fzf-tmux`
      set -g @sessionx-filter-current 'on'      # the current session will not be shown on first view
    '';
  } ];
}
