{
  flake-file.inputs.claude-desktop.url = "github:aaddrick/claude-desktop-debian";

  flake.aspects.ai.homeManager = { pkgs, ... }:{ 
    nixpkgs.overlays = [ claude-desktop.overlays.default ];
    # environment.systemPackages = [ pkgs.claude-desktop ];
  };
}
