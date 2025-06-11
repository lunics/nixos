{ pkgs ? import <nixpkgs> {} }:

let
  custom-tmux-fzf = pkgs.tmuxPlugins.tmux-fzf.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      # Replace the original window.sh with the custom version
      cp ${./plugins/window.sh} $out/share/tmux-plugins/tmux-fzf/scripts/window.sh
    '';
  });
in
{
  # Use custom-tmux-fzf in your configuration
  environment.systemPackages = [ custom-tmux-fzf ];
}

