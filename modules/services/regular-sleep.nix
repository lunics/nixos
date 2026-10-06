{
  flake.aspects.regular-sleep-svc.homeManager = { config, pkgs, ... }:
  let
    _bin    = "/run/current-system/sw/bin";
    _notify = "${config._.home}/.nix-profile/bin/notify-send";

    # logind answers CanHibernate unprivileged: yes, no, na or challenge
    _script = pkgs.writeShellScript "regular-sleep" ''
      _action=suspend
      if [ "$(${_bin}/busctl call org.freedesktop.login1 /org/freedesktop/login1 \
           org.freedesktop.login1.Manager CanHibernate)" = 's "yes"' ]; then
        _action=hibernate
      fi

      ${_notify} -t 5000 "$_action in 10 minutes"
      ${_bin}/sleep 300
      ${_notify} -t 10000 "$_action in 5 minutes"
      ${_bin}/sleep 300
      ${_notify} -t 10000 -u critical "$_action in 10 seconds"
      ${_bin}/sleep 10
      ${_bin}/systemctl "$_action"
    '';
  in {
    systemd.user = {
      timers."regular-sleep" = {
        Unit.Description = "Suspend or hibernate (if supported) machine every night at 23:00 pm";
        Timer = {
          OnCalendar = "22:50";
          Persistent = false;
        };
        Install.WantedBy = [ "default.target" ];
      };

      services."regular-sleep" = {
        Unit.Description = "suspend or hibernate machine once regular-sleep.timer is triggered";
        Service = {
          Type      = "oneshot";
          ExecStart = "${_script}";
        };
      };
    };
  };
}
