{ config, pkgs, ... }:{
  programs.tmux.plugins = with pkgs.tmuxPlugins; [{
    plugin = resurrect;
    extraConfig = ''
      bind -n M-C-s run-shell -b ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/save.sh
      bind -n M-C-r run-shell -b ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/restore.sh

      set -g @resurrect-capture-pane-contents "on"
      set -g @resurrect-strategy-nvim "session"
      set -g @resurrect-processes "taskwarrior-tui yazi"          # additional programs we want to restore
        # programs restored by default: vi vim nvim emacs man less more tail top htop irssi weechat mutt
      # set -g @resurrect-save        "S"                         # already set in binds with M-C-s
      # set -g @resurrect-restore     "R"                         # NOT SET
      set -g @resurrect-dir           "${config._.share}/tmux"    # only $HOME and ~ are enabled
    '';
  }];
}
