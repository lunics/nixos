{ config, pkgs, ... }:{
  nixpkgs.overlays = [
    (final: prev: {
      nixos-auto-upgrade = prev.writeShellApplication {
        name = "nixos-auto-upgrade";
        text = ''
          env \
            HOME=/home/${config._.user} \
            GIT_CONFIG_COUNT=1 \
            GIT_CONFIG_KEY_0=safe.directory \
            GIT_CONFIG_VALUE_0=${config._.flake_dir} \
            ${pkgs.nixos-rebuild-ng}/bin/nixos-rebuild switch --flake ${config._.flake_dir}#${config._.hostName}

          # ${pkgs.git}/bin/git config --global --add safe.directory ${config._.flake_dir}

          # ${pkgs.nixos-rebuild-ng}/bin/nixos-rebuild switch --flake ${config._.flake_dir}#${config._.hostName}

          # ${pkgs.git}/bin/git config --global --unset safe.directory ${config._.flake_dir}

          ## MODIFY LAST INVENTOY REPO WITH NEW HM GENERATION NUMBER
        '';
      };
    })
  ];
}
