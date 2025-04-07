{
  systemd.services."suspend@lunics" = {
    name        = "suspend@lunics.service";
    after       = [ "suspend.target" ];
    description = "Call user's suspend target after system suspend";

    serviceConfig = {
      Type      = "oneshot";
      ExecStart = "/run/current-system/sw/bin/systemctl --user --machine=%i@ start --wait suspend.target";
    };

    wantedBy    = [ "suspend.target" ];
  };

  systemd.user.targets."suspend" = {
    name        = "suspend.target";
    description = "User level suspend target";
    unitConfig.StopWhenUnneeded = true;
    wants       = [ "pomodoro.service" ];
  };
}
