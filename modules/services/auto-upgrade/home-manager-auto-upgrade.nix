{ config, pkgs, ... }:
let
  scriptOverlay = self: super: {
    home-manager-auto-upgrade = super.writeShellApplication {
      name = "home-manager-auto-upgrade";

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

        echo "Upgrade Home Manager"
        home-manager switch --flake ./#${config._.user}

        ## MODIFY LAST INVENTOY REPO WITH NEW HM GENERATION NUMBER
      '';
    };
  };
in {
  nixpkgs.overlays = [ scriptOverlay ];

  home.packages = [ pkgs.home-manager-auto-upgrade ];
}
