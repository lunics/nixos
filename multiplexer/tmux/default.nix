{ pkgs, ... }:
let
  # override the file window.sh from the tmux-fzf plugin
  custom-tmux-fzf = pkgs.tmuxPlugins.tmux-fzf.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      # Replace the original window.sh with the custom version
      mkdir -p $out/share/tmux-plugins/tmux-fzf/scripts
      cp ${./plugins/window.sh} $out/share/tmux-plugins/tmux-fzf/scripts/window.sh
    '';
  });
in {
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
      copycat
      better-mouse-mode
      extrakto            # manage clipboard into tmux
      fuzzback            # fzf search in scrollback mode
      tmux-floax
      urlview

      # sessionx
      # session-wizard
      # sessionist

      # tilish            i3 motion like
      # jump
      # pass

      # powerline
      # power             pourquoi pas l'intégrer en version allégée
      # loggin            Easy logging and screen capturing for Tmux
      # mode-indicator    displays prompt current active Tmux mode
      # tmux-prefix-highlight

      # tmux-update-display KO
      # tmux-autoreload
      # tmux-sensible

      # yank
      # vim-tmux-navigator
      # pain-control
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
    ];

    extraConfig = ''
      ${ builtins.readFile ./options    }
      ${ builtins.readFile ./status_bar }
    '';
  };

  imports = [
    (import ./binds.nix { inherit pkgs custom-tmux-fzf; })
  ];

  # programs.cron = {
  #   enable = true;
  #   # Define your cron jobs here
  #   crontab = ''
  #     # Example: Run a script every day at 3:30 AM
  #     30 3 * * * /home/your-username/.config/scripts/your-script.sh
  #   '';
  # };

}
