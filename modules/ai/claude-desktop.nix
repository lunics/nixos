{ inputs, ... }:{
  flake-file.inputs.claude-desktop.url = "github:aaddrick/claude-desktop-debian";

  flake.aspects.ai.homeManager = { pkgs, ... }:{ 
    nixpkgs.overlays = [ inputs.claude-desktop.overlays.default ];
    home.packages = [ pkgs.claude-desktop ];
  };
}
