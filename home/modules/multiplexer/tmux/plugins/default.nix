{ pkgs, ... }:{
  programs.tmux.plugins = with pkgs.tmuxPlugins; [
    sensible
    copycat
    better-mouse-mode
    extrakto            # manage clipboard into tmux
    fuzzback            # fzf search in scrollback mode
    urlview

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
  ];

  imports = [
    ./sessionx.nix
    ./resurrect.nix
    ./floax.nix
    ./tmux-fzf
  ];
}
