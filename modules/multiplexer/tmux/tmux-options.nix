{
  flake.aspects.multiplexer.homeManager = {
    programs.tmux.extraConfig = ''
      set -g pane-border-lines heavy
      set -g pane-active-border-style fg=green
      set -g set-titles        on
      set -g set-titles-string "#H:#S.#I.#P #W #T"
      set -g visual-activity   off                    # désactive le message d'entrée précisant le numéro de l'active window
      set -g allow-passthrough on
      set -g renumber-windows  on

      # fix french dead keys (^ ¨ -> ê ë) under ghostty: tmux doesn't speak the
      # kitty keyboard protocol, so ghostty's composed-char sequences get dropped.
      # negotiate & forward extended keys in a format tmux understands instead.
      set -s extended-keys on
      set -as terminal-features 'xterm*:extkeys'
      set -g extended-keys-format csi-u
    '';
  };
}
