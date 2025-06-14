# tmux config can't be reloaded without exiting the current session, because pointing the older home-manager symlink
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
      # {
      #   plugin = tmux-floax;
      #   extraConfig = ''
      #     # Setting the main key to toggle the floating pane on and off
      #     set -g @floax-bind '-n M-f'

      #     # When the pane is toggled, using this bind pops a menu with additional options
      #     # such as resize, fullscreen, resetting to defaults and more.
      #     set -g @floax-bind-menu 'P'
          
      #     # The default width and height of the floating pane
      #     set -g @floax-width '80%'
      #     set -g @floax-height '80%'
          
      #     # The border color can be changed, these are the colors supported by Tmux:
      #     # black, red, green, yellow, blue, magenta, cyan, white for the standard
      #     # terminal colors; brightred, brightyellow and so on for the bright variants;
      #     # colour0/color0 to colour255/color255 for the colors from the 256-color
      #     # palette; default for the default color; or a hexadecimal RGB color such as #882244.
      #     set -g @floax-border-color '00af17'
          
      #     # The text color can also be changed, by default it's blue 
      #     # to distinguish from the main window
      #     # Optional colors are as shown above in @floax-border-color
      #     set -g @floax-text-color 'blue'
          
      #     # By default when floax sees a change in session path 
      #     # it'll change the floating pane's path
      #     # You can disable this by setting it to false
      #     # You could also "cd -" when the pane is toggled to go back
      #     set -g @floax-change-path 'true'
          
      #     # The default session name of the floating pane is 'scratch'
      #     # You can modify the session name with this option:
      #     set -g @floax-session-name 'floax-session-name'
          
      #     # Change the title of the floating window
      #     set -g @floax-title 'float'
      #   '';
      # }
    ];

    extraConfig = ''
      ${ builtins.readFile ./options    }
      ${ builtins.readFile ./status_bar }
    '';
  };

  imports = [
    (import ./binds.nix { inherit pkgs custom-tmux-fzf; })
    ./plugins/floax.nix
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
