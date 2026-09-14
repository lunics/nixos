{
  flake.aspects.librepods.homeManager = { config, lib, pkgs, ... }: with lib;
  let
    airpods = findFirst (device: device.name == "airpods") null config._.bluetooth-devices;
    dev     = "dev_" + toUpper (replaceStrings [ ":" ] [ "_" ] (if airpods == null then "" else airpods.mac));

    watcher = pkgs.writeShellApplication {
      name          = "librepods-watcher";
      runtimeInputs = with pkgs; [ coreutils dbus gawk gnugrep systemd ];
      text          = ''
        dev="${dev}"

        # the AirPods may already be connected when the watcher starts
        for hci in /sys/class/bluetooth/hci*; do
          [ -e "$hci" ] || continue
          if busctl --system get-property org.bluez "/org/bluez/$(basename "$hci")/$dev" \
               org.bluez.Device1 Connected 2>/dev/null | grep -q true; then
            systemctl --user start librepods.service
          fi
        done

        dbus-monitor --system "type='signal',interface='org.freedesktop.DBus.Properties',path_namespace='/org/bluez'" \
          | awk -v dev="$dev" '
              /^signal /           { seen = index($0, dev) > 0; pending = 0 }
              /string "Connected"/ { pending = seen; next }
              pending && /boolean/ { pending = 0; if ($0 ~ /true/) print "start"; else print "stop"; fflush() }
            ' \
          | while read -r action; do systemctl --user "$action" librepods.service; done
      '';
    };
  in mkIf (airpods != null) {
    systemd.user.services = {
      "librepods" = {
        Unit = {
          Description = "LibrePods tray app, started while the AirPods are connected";
          PartOf      = [ "hyprland-session.target" ];
          After       = [ "hyprland-session.target" ];
        };
        Service = {
          Type      = "simple";
          ExecStart = "${pkgs.librepods}/bin/librepods --hide";
          Restart   = "on-failure";
        };
        # no Install section: started on demand by librepods-watcher.service
      };

      "librepods-watcher" = {
        Unit = {
          Description = "Follow the AirPods bluetooth connection to start/stop librepods";
          PartOf      = [ "hyprland-session.target" ];
          After       = [ "hyprland-session.target" ];
        };
        Service = {
          Type         = "simple";
          ExecStart    = "${watcher}/bin/librepods-watcher";
          ExecStopPost = "-${pkgs.systemd}/bin/systemctl --user stop librepods.service";
          Restart      = "on-failure";
          RestartSec   = 5;
        };
        Install.WantedBy = [ "hyprland-session.target" ];
      };
    };
  };
}
