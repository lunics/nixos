{
  flake.aspects.auto-upgrade.nixos = { config, pkgs, ... }:{
    nixpkgs.overlays = [
      (final: prev: {
        flake-update = prev.writeShellApplication {
          name          = "flake-update";
          runtimeInputs = with prev; [ nix ];
          text = ''
            FLAKE_DIR=${config._.flake_dir}

            set -e
            if [[ ! -f "$FLAKE_DIR/flake.nix" ]]; then
              echo "no flake.nix found in $FLAKE_DIR" >&2
              exit 1
            fi

            echo "changing to flake directory $FLAKE_DIR"
            cd "$FLAKE_DIR"

            echo "updating all flake inputs"
            nix flake update
          '';
        };
      })
    ];
  };
}
