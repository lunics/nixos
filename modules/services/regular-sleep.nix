{
  flake.aspects.regular-sleep.homeManager = { config, osConfig ? null, ... }:
  let
    # HM does not inherit the nixos `_` values, standalone HM has no osConfig
    _hiber  = (if osConfig != null then osConfig else config)._.swapfile-hibernation;
    _action = if _hiber.enable && _hiber.resume_offset != null then "hibernate" else "suspend";
    _notify = "${config._.home}/.nix-profile/bin/notify-send";
    _sleep  = "/run/current-system/sw/bin/sleep";
  in {
    systemd.user = {
      timers."regular-sleep" = {
        Unit.Description = "${_action} laptop every night at 23:00 pm";
        Timer = {
          OnCalendar = "22:50";
          Persistent = false;
        };
        Install.WantedBy = [ "default.target" ];
      };

      services."regular-sleep" = {
        Unit.Description = "${_action} laptop once regular-sleep.timer is triggered";
        Service = {
          Type      = "oneshot";
          ExecStart = [
            "${_notify} -t 5000 '${_action} in 10 minutes'"
            "${_sleep} 300"
            "${_notify} -t 10000 '${_action} in 5 minutes'"
            "${_sleep} 300"
            "${_notify} -t 10000 -u critical '${_action} in 10 seconds'"
            "${_sleep} 10"
            "/run/current-system/sw/bin/systemctl ${_action}"
          ];
        };
      };
    };
  };
}
