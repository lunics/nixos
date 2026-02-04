{ config, pkgs, ... }:{
  systemd.user.services."pomodoro" = {
    Unit = {
      Description = "endless pomodoro";
      # Requires    = [ "pomodoro.timer" ];
      # After       = [ "default.target" "suspend.target" ];
    };
    Service = {
      Type        = "simple";
      Environment = [
        "XDG_RUNTIME_DIR=/run/user/${toString config._.user_id}"
        "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/${toString config._.user_id}/bus"
      ];
      ExecStart   = [ "${pkgs.nu-pomodoro}/bin/nu-pomodoro" ];
    };
    # Install.WantedBy = [ "suspend.target" ];
  };
}
