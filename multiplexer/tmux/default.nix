{ pkgs, ... }:

let
  custom-tmux-fzf = pkgs.tmuxPlugins.tmux-fzf.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      # Replace the original window.sh with the custom version
      mkdir -p $out/share/tmux-plugins/tmux-fzf/scripts
      cp ${./plugins/window.sh} $out/share/tmux-plugins/tmux-fzf/scripts/window.sh
    '';
  });
in {

# home.packages = with pkgs; [
#   # tmux            # depends on screen for working
#   # tmuxp           # tmuxinator like en plus pratique ?
#   # # tmuxinator    # no more needed with tmux-resurrect plugin
#   # entr            # tmux-autoreload plugin dependence
#   # python-libtmux  # for tmux-window-name plugin
#   # git             # to clone the repos of tmux plugins
#   # tmux-sessionizer    # cli tool to fuzzy find all git repositories in a list of specified folders and open them as a new tmux session
# ];

  programs.tmux = {
    enable       = true;
    prefix       = "C-a";             # Ctrl + a as prefix key
    terminal     = "tmux-256color";   # $TERM, tmux-256color, screen-256color, xterm-256color
    historyLimit = 100000;
    clock24      = true;
    baseIndex    = 1;
    keyMode      = "vi";
    mouse        = true;

    plugins = with pkgs.tmuxPlugins; [
      custom-tmux-fzf
      sensible
      # tmux-update-display KO
      # tmux-autoreload
      # tmux-sensible

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
          set -g @resurrect-capture-pane-contents "on"
          set -g @resurrect-strategy-nvim "session"
          set -g @resurrect-save          "S"
          set -g @resurrect-restore       "R"
          set -g @resurrect-dir           "$HOME/usb_copy/homelab/share/tmux"   # only $HOME and ~ are enabled
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore       'on'
          set -g @continuum-boot          'on'
          set -g @continuum-save-interval '30'  # save session every N minutes
        '';
      }
    ];

    extraConfig = ''
      ${ builtins.readFile ./options    }
      ${ builtins.readFile ./status_bar }
    '';
  };

  imports = [
    ./binds.nix
    # ./override_tmux-fzf.nix
  ];
}
