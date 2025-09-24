{ pkgs, ... }:{
  home.packages = with pkgs; [
    (pkgs.writeShellApplication {
      name = "restore_tmux";                   # restore all sessions then switch to home session

      runtimeInputs = with pkgs; [ 
        tmux
      ];

      text = ''
        tmux new-session -d -s dummy \; \
          run-shell "${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/restore.sh" \; \
          kill-session -t dummy \; \
          attach -t home
      '';
    })
  ];
}
