{ pkgs, ... }:{
  systemd.user = {
    services."playerctld" = {
      Unit.Description = "keep track of media player activity";

      Service = {
        Type      = "oneshot";
        ExecStart = "${pkgs.playerctld}/bin/playerctld daemon";
      };

      Install.WantedBy  = [ "default.target" ];
    };
  };
}
