{ pkgs, ... }:{
  home.packages = [
    (pkgs.tmuxPlugins.tmux-fzf.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        # Replace the original window.sh with the custom version
        mkdir -p $out/share/tmux-plugins/tmux-fzf/scripts
        cp ${./plugins/window.sh} $out/share/tmux-plugins/tmux-fzf/scripts/window.sh
      '';
    }))
  ];

  # Optionally, ensure the custom script directory exists
  home.file.".config/tmux/custom-scripts/window.sh".source = ./plugins/window.sh;
}
