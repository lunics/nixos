{ inputs, ... }:{
  flake-file.inputs.claude-desktop.url = "github:aaddrick/claude-desktop-debian";

  flake.overlays.claude-desktop = inputs.claude-desktop.overlays.default;   # applied by the builders

  flake.aspects.claude-desktop.homeManager = { pkgs, ... }:{
    _.allow-unfree = with pkgs; [ claude-desktop ];

    _.add_to_startup = [ "claude-desktop" ];

    _.persistent-home.dirs = [ ".config/Claude" ];
  };
}
