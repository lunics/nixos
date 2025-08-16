{ config, lib, ... }:{
  config = lib.mkIf (config._.status_bar == "hyprpanel") {
    programs.hyprpanel = {
      enable          = true;
      # package         = pkgs.hyprpanel;
      systemd.enable  = true;
      dontAssertNotificationDaemons = true;     # don't use hyprpanel as a notification daemons, because buggy

      settings = {
        bar.battery.label = true;
        bar.bluetooth.label = false;
        bar.clock.format = "%H:%M:%S";
        bar.layouts = {
          "*" = {
            left = [
              "dashboard"
              "workspaces"
              "media"
            ];
            middle = [ "windowtitle" ];
            right = [
              "volume"
              "network"
              "bluetooth"
              "notifications"
            ];
          };
        };
      };


      # theme           = "gruvbox_split";
      # override = {
      #   enable  = true;
      #   theme.bar.menus.text = "#123ABC";
      # };

      # layout = {   # See 'https://hyprpanel.com/configuration/panel.html'.
      #   "bar.layouts" = {
      #     "0" = {
      #       left   = [ "dashboard" "workspaces" ];
      #       middle = [ "media" ];
      #       right  = [ "volume" "systray" "notifications" ];
      #     };
      #   };
      # };

      # Configure and theme almost all options from the GUI.
      # Options that require '{}' or '[]' are not yet implemented,
      # except for the layout above.
      # See 'https://hyprpanel.com/configuration/settings.html'.
      # Default: <same as gui>
      # settings = {
      #   bar.launcher.autoDetectIcon = true;
      #   bar.workspaces.show_icons = true;

      #   menus.clock = {
      #     time = {
      #       military = true;
      #       hideSeconds = true;
      #     };
      #     weather.unit = "metric";
      #   };

      #   menus.dashboard.directories.enabled = false;
      #   menus.dashboard.stats.enable_gpu = true;

      #   theme.bar.transparent = true;

      #   theme.font = {
      #     name = "CaskaydiaCove NF";
      #     size = "16px";
      #   };
      # };
    };
  };
}
