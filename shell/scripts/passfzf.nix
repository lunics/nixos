{ pkgs }: pkgs.writeShellApplication {

  name = "passfzf";
  runtimeInputs = with pkgs; [ passage fzf ];

    # PREFIX="${PASSAGE_DIR:-$HOME/.passage/store}"
  text = ''
    set -eou pipefail
    
    # FZF_DEFAULT_OPTS=""
    PREFIX="$PASSAGE_DIR"
    
    name="$(find "$PREFIX" -type f -name '*.age' | \
      sed -e "s|$PREFIX/||" -e 's|\.age$||' | \
      fzf --height 40% --reverse --no-multi)"
    
    # passage "$@" "$name"
    passage edit "$name"
  '';
}
