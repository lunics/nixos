{ config, pkgs, ... }:{
  systemd.user = {
    timers."tmux-save" = {
      Unit.Description = "run tmux-save.service every 5 minutes";
      Timer = {
        OnBootSec       = "1min";
        OnUnitActiveSec = "15min";
        Unit            = "tmux-save.service";
      };
      Install.WantedBy  = [ "timers.target" ];
    };

    services."tmux-save" = {
      Unit = {
        Description = "run tmux_resurrect/scripts/save.sh to save tmux sessions";
        OnFailure   = "error@%n.service";
      };

      Service = {
        Type      = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash %h/.config/systemd/user/tmux-save.sh";
      };
    };
  };

  xdg.configFile."systemd/user/tmux-save.sh".text = ''
    if pgrep tmux; then
      if ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/save.sh quiet; then
        cd ${config._.share}/tmux
        ls -t tmux_resurrect_* | tail -n +40 | xargs rm -f
      fi
    fi
  '';
}
