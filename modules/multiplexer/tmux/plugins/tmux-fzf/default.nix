{ pkgs, ... }:
let
  # override the file window.sh from the tmux-fzf plugin
  custom-tmux-fzf = pkgs.tmuxPlugins.tmux-fzf.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      # Replace the original window.sh with the custom version
      mkdir -p $out/share/tmux-plugins/tmux-fzf/scripts
      cp ${./window_custom.sh} $out/share/tmux-plugins/tmux-fzf/scripts/window.sh
    '';
  });
in {
  programs.tmux = {
    plugins = [ custom-tmux-fzf ];
    # plugins = with pkgs.tmuxPlugins; [ 
    #   custom-tmux-fzf
    #   # tmux-fzf
    # ];
    extraConfig = ''
      TMUX_FZF_PREVIEW=0                  # 0 = disable fzz preview
      TMUX_FZF_OPTIONS="-p -w 30%"
      TMUX_FZF_ORDER="session|window|pane|command|keybinding|clipboard|process"
      # TMUX_FZF_MENU_POPUP_WIDTH=50%
      # TMUX_FZF_MENU_POPUP_HEIGHT=50%
      TMUX_FZF_SWITCH_CURRENT=0           # 0 = the current session, window, and pane, are not listed among the switch possibilities

      # TMUX_FZF_PANE_FORMAT="[#{window_name}] #{pane_current_command}  [#{pane_width}x#{pane_height}] [history #{history_size}/#{history_limit}, #{history_bytes} bytes] #{?pane_active,[active],[inactive]}"
      # TMUX_FZF_WINDOW_FORMAT="#{window_name}"
      # TMUX_FZF_WINDOW_FILTER=

      bind -n M-k run-shell -b "${custom-tmux-fzf}/share/tmux-plugins/tmux-fzf/scripts/window.sh switch"
      ## bind -n M-s run-shell -b "${custom-tmux-fzf}/share/tmux-plugins/tmux-fzf/scripts/session.sh switch"
        ## learn sessionx before using this command
    '';
  };
  # /nix/store/n7v67m1f7n27dh61silvyy5rq1fpzkng-tmuxplugin-tmux-fzf-unstable-2023-10-24/share/tmux-plugins/tmux-fzf/scripts
  #   clipboard.sh
  #   command.sh
  #   copy-mode.sh
  #   keybinding.sh
  #   menu.sh
  #   pane.sh
  #   process.sh
  #   session.sh
  #   window.sh
}
