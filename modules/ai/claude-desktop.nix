{ inputs, ... }:{
  flake-file.inputs.claude-desktop.url = "github:aaddrick/claude-desktop-debian";

  flake.aspects.ai.homeManager = { pkgs, ... }:{ 
    nixpkgs.overlays = [ inputs.claude-desktop.overlays.default ];
    _.allow-unfree = with pkgs; [ claude-desktop ];
  };
}
