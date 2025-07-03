{
# already in nixpkgs
# { inputs, ... }:{
#   imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];
#       # inputs.flake-neovim.packages."${system}".default

  programs.hyprpanel = {
    enable = true;
    systemd.enable    = true;
    hyprland.enable   = false;    # Add hyprpanel' to your Hyprland config 'exec-once'.
    theme             = "gruvbox_split";
    override = {
      enable  = true;
      theme.bar.menus.text = "#123ABC";
    };

    layout = {   # See 'https://hyprpanel.com/configuration/panel.html'.
      "bar.layouts" = {
        "0" = {
          left   = [ "dashboard" "workspaces" ];
          middle = [ "media" ];
          right  = [ "volume" "systray" "notifications" ];
        };
      };
    };

    # Configure and theme almost all options from the GUI.
    # Options that require '{}' or '[]' are not yet implemented,
    # except for the layout above.
    # See 'https://hyprpanel.com/configuration/settings.html'.
    # Default: <same as gui>
    settings = {
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;

      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.unit = "metric";
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = true;

      theme.bar.transparent = true;

      theme.font = {
        name = "CaskaydiaCove NF";
        size = "16px";
      };
    };
  };
}
