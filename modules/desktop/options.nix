{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      status_bar = mkOption {
        type    = types.str;
        default = "hyprpanel";
      };

      notifier = mkOption {
        type    = types.str;
        default = "hyprpanel";
      };

      add_to_startup = mkOption {
        type    = types.listOf types.str;
        default = "";
      };

      hyprpanel_modules = mkOption {
        type    = types.attrsOf types.anything;
        default = {};
      };

      dms_left_widgets = mkOption {
        type    = types.listOf types.str;
        default = [];
      };

      lock-screen = mkOption {
        type    = types.str;
        default = "";
      };

      # command run to lock the screen, set by the lock screen aspect itself
      lock-cmd = mkOption {
        type    = types.str;
        default = "";
      };
    };
  };
}
