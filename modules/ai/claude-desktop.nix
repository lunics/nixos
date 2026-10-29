{ inputs, ... }:{
  flake-file.inputs.claude-desktop.url = "github:aaddrick/claude-desktop-debian";

  flake.aspects.claude-desktop.homeManager = { pkgs, ... }:{
    nixpkgs.overlays = [ inputs.claude-desktop.overlays.default ];

    _.allow-unfree = with pkgs; [ claude-desktop ];

    _.add_to_startup = [ "claude-desktop" ];

    _.persistent-home.dirs = [ ".config/Claude" ];
  };
}
