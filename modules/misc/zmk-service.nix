{
  flake.aspects.zmk.homeManager = { config, lib, pkgs, ... }: with lib;
  let
    # the name casing is free-form in bluetooth-devices ("Splitkb"), so compare it lowercased
    splitkb = findFirst (device: toLower device.name == "splitkb") null config._.bluetooth-devices;
    dev     = "dev_" + toUpper (replaceStrings [ ":" ] [ "_" ] (if splitkb == null then "" else splitkb.mac));

    watcher = pkgs.writeShellApplication {
      name          = "zmkbatx-watcher";
      runtimeInputs = with pkgs; [ coreutils dbus gawk gnugrep systemd ];
      text          = ''
        dev="${dev}"

        # the keyboard may already be connected when the watcher starts
        for hci in /sys/class/bluetooth/hci*; do
          [ -e "$hci" ] || continue
          if busctl --system get-property org.bluez "/org/bluez/$(basename "$hci")/$dev" \
               org.bluez.Device1 Connected 2>/dev/null | grep -q true; then
            systemctl --user start zmkbatx.service
          fi
        done

        dbus-monitor --system "type='signal',interface='org.freedesktop.DBus.Properties',path_namespace='/org/bluez'" \
          | awk -v dev="$dev" '
              /^signal /           { seen = index($0, dev) > 0; pending = 0 }
              /string "Connected"/ { pending = seen; next }
              pending && /boolean/ { pending = 0; if ($0 ~ /true/) print "start"; else print "stop"; fflush() }
            ' \
          | while read -r action; do systemctl --user "$action" zmkbatx.service; done
      '';
    };
  in mkIf (splitkb != null) {
    systemd.user.services = {
      "zmkbatx" = {
        Unit = {
          Description = "zmkbatx tray app, started while the splitkb keyboard is connected";
          PartOf      = [ "hyprland-session.target" ];
          After       = [ "hyprland-session.target" ];
        };
        Service = {
          Type      = "simple";
          ExecStart = "${pkgs.zmkbatx}/bin/zmkbatx";
          Restart   = "on-failure";
        };
        # no Install section: started on demand by zmkbatx-watcher.service
      };

      "zmkbatx-watcher" = {
        Unit = {
          Description = "Follow the splitkb bluetooth connection to start/stop zmkbatx";
          PartOf      = [ "hyprland-session.target" ];
          After       = [ "hyprland-session.target" ];
        };
        Service = {
          Type         = "simple";
          ExecStart    = "${watcher}/bin/zmkbatx-watcher";
          ExecStopPost = "-${pkgs.systemd}/bin/systemctl --user stop zmkbatx.service";
          Restart      = "on-failure";
          RestartSec   = 5;
        };
        Install.WantedBy = [ "hyprland-session.target" ];
      };
    };
  };
}
