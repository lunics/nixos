{ config, pkgs, ... }:{
  programs.tmux.plugins = with pkgs.tmuxPlugins; [{
    plugin = resurrect;
    extraConfig = ''
      bind -n M-C-s run-shell -b ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/save.sh
      bind -n M-C-r run-shell -b ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/restore.sh

      set -g @resurrect-capture-pane-contents "on"
      set -g @resurrect-strategy-nvim "session"
      set -g @resurrect-processes "vi nvim vim yazi ssh taskwarrior-tui irssi weechat mutt"   # additional programs we want to restore
      set -g @resurrect-hook-post-save-all "sed -i 's| --cmd .*-vim-pack-dir||g; s|/home/$USER/.nix-profile/bin||g; s|/nix/store/.*/bin/||g' $(readlink -f ${config._.share}/tmux/last)"
      # set -g @resurrect-save        "S"                         # already set in binds with M-C-s
      # set -g @resurrect-restore     "R"                         # NOT SET
      set -g @resurrect-dir           "${config._.share}/tmux"    # only $HOME and ~ are enabled
    '';
  }];
}
