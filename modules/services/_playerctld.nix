{
  flake.aspects.playerctld.homeManager = { pkgs, ... }:{
    systemd.user = {
      services."playerctld" = {
        Unit.Description = "keep track of media player activity";

        Service = {
          Type      = "oneshot";
          ExecStart = "${pkgs.playerctl}/bin/playerctld daemon";
        };

        Install.WantedBy  = [ "default.target" ];
      };
    };
  };
}
