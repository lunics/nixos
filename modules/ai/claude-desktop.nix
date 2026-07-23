{ inputs, ... }:{
  flake-file.inputs.claude-desktop.url = "github:aaddrick/claude-desktop-debian";

  flake.aspects.ai.homeManager = { config, lib, pkgs, ... }:{ 
    nixpkgs.overlays = [ inputs.claude-desktop.overlays.default ];

    _.allow-unfree = with pkgs; [ claude-desktop ];

    _.add_to_startup = [ "claude-desktop" ];


    home.activation.link-claude-desktop-share = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      link=${config._.dot_config}/Claude

      if [ -e $(dirnam $link) ] && [ ! -L $link ] && [ -d ${config._.share}/claude-desktop ]; then
        ln -s ${config._.share}/claude-desktop $link &> /dev/null || true
      fi
    '';
  };
}
