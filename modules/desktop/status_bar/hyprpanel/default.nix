{ config, lib, pkgs, ... }:{
  config = lib.mkIf (config._.status_bar == "hyprpanel") {
    # home.packages = with pkgs; [
    #   astal.battery   ## required for battery level ?
    # ];
    home.file.".config/hyprpanel/taskwarrior.sh" = {
      source = ./taskwarrior.sh;
      executable = true;
    };

    programs.hyprpanel = {
      enable          = true;
      # package         = pkgs.hyprpanel;
      systemd.enable  = true;
      dontAssertNotificationDaemons = true;     # don't use hyprpanel as a notification daemons, because buggy

      settings = {
        menus = {
          transition = "crossfade";
          clock = {
            weather = {
              location = "Paris";
              unit     = "metric";
            };
            time = {
              hideSeconds = false;
              military    = true;
            };
          };
        };

        scalingPriority = "hyprland";

        bar = {
          autoHide          = "never";
          launcher.icon     = " 󱄅 ";
          systray.ignore    = ["udiskie"];
          bluetooth.label   = false;
          windowtitle.icon  = false;
          customModules.weather.unit = "metric";
          battery.hideLabelWhenFull  = false;
          network = {
            label        = true;
            showWifiInfo = true;
          };
          workspaces = {
            show_icons                = false;
            showWsIcons               = true;
            showApplicationIcons      = false;
            numbered_active_indicator = "highlight";
          };
          clock = {
            showIcon = false;
            format   = "%H:%M";
            showTime = true;
          };
          layouts = {
            "*" = {
              left = [
                "dashboard"
                "workspaces"
                "custom/taskwarrior"
              ];
              middle = [ 
                # "windowtitle" 
                "clock"
              ];
              right = [
                # "media"
                "volume"
                "battery"
                "network"
                "bluetooth"
                "notifications"
                "weather"
                "cputemp"
                "systray"
              ];
            };
          };
        };

        notifications.position = "top right";

        theme = {
          bar = {
            transparent          = true;
            opacity              = 60;
            location             = "top";
            border_radius        = "0.5em";
            margin_top           = "0.5em";
            enableShadow         = false;
            dropdownGap          = "3em";
            outer_spacing        = "0.4em";
            battery.label        = true;
            notification.opacity = 80;
            buttons = {
              opacity       = 100;
              enableBorders = true;
              borderSize    = "0.01em";
              padding_x     = "0.5rem";
              padding_y     = "0.1rem";
              spacing       = "0.2em";
              radius        = "0.5em";
              style         = "default";
              text          = "#99c1f1";
              icon          = "#99c1f1";
              borderColor   = "#b4befe";
              background    = "#242438";
              monochrome    = true;
              background_opacity        = 50;
              background_hover_opacity  = 70;
              separator.margins         = "0.15em";
              network.enableBorder      = false;
              battery.enableBorder      = false;
              clock.spacing             = "0em";
              workspaces = {
                smartHighlight = true;
                enableBorder   = false;
                hover          = "#99c1f1";
                active         = "#99c1f1";
                occupied       = "#99c1f1";
              };
            };
            border = {
              width        = "0.15em";
              location     = "none";
              border.color = "#b4befe";
            };
            menus = {
              opacity        = 85;
              enableShadow   = false;
              buttons.radius = "0.4em";
            };
          };
          osd = {
            orientation  = "horizontal";
            location     = "top";
            duration     = 2000;
            radius       = "0.5em";
            muted_zero   = false;
            enableShadow = true;
            margins      = "7px 7px 7px 7px";
          };
        };
      };
    };
  };
}
