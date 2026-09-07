{
  flake.aspects.multiplexer.homeManager = { config, pkgs, ... }:{
    home.packages = with pkgs; [
      (pkgs.writeShellApplication {
        name = "restore_tmux";                   # restore all sessions then switch to home session

        runtimeInputs = with pkgs; [ 
          tmux
        ];

        text = ''
          if [ -d "${config._.tmux.sessions-dir}" ]; then
            # restore from a client-attached hook: panes respawned while no client is
            # attached (yazi, nvim...) get no answer to their terminal capability probes
            tmux new-session -d -s dummy \; \
              set-hook -t dummy client-attached[0] "run-shell '${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/restore.sh'" \; \
              set-hook -t dummy client-attached[1] "if-shell 'tmux has-session -t home' 'switch-client -t home ; kill-session -t dummy'" \; \
              attach -t dummy
          else
            exec $SHELL
          fi
        '';
      })
    ];
  };
}
