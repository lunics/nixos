{ pkgs }:
let
  tmux-super-fingers = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-autoreload";
    version    = "unstable-2023-01-06";
    src = pkgs.fetchFromGitHub {
      owner  = "artemave";
      repo   = "tmux_super_fingers";
      rev    = "2c12044984124e74e21a5a87d00f844083e4bdf7";
      sha256 = "sha256-cPZCV8xk9QpU49/7H8iGhQYK6JwWjviL29eWabuqruc=";
    };
  };
in
{
  inherit tmux-super-fingers;
}

