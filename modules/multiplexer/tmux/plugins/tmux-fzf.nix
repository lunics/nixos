{ pkgs, ... }:
let
  # override the file window.sh from the tmux-fzf plugin
  custom-tmux-fzf = pkgs.tmuxPlugins.tmux-fzf.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      # Replace the original window.sh with the custom version
      mkdir -p $out/share/tmux-plugins/tmux-fzf/scripts
      cp ${./window.sh} $out/share/tmux-plugins/tmux-fzf/scripts/window.sh
    '';
  });
in {
  programs.tmux.plugins = with pkgs.tmuxPlugins; [ 
    custom-tmux-fzf
  ];
}
