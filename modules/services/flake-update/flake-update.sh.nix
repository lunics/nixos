{ config, pkgs, ... }:
let
  script_overlay = self: super: {
    flake-update = super.writeShellApplication {
      name = "flake-update";

      text = ''
        FLAKE_DIR=${config._.flake_dir}
        
        # export PATH="/nix/store/ihxcykgfmgvymd1fq5zrfs14q2cplczs-home-manager/bin:/nix/store/vfgzadk2clbi922nixidc7w2hf9na4dz-nix-2.31.3/bin:$PATH"
        
        set -e
        if [[ ! -f "$FLAKE_DIR/flake.nix" ]]; then
          echo "No flake.nix found in $FLAKE_DIR." >&2
          exit 1
        fi
        
        echo "Changing to flake directory $FLAKE_DIR"
        cd "$FLAKE_DIR"

        echo "Update all flake inputs"
        nix flake update
      '';
    };
  };
in {
  nixpkgs.overlays = [ script_overlay ];

  home.packages = [ pkgs.flake-update ];
}
