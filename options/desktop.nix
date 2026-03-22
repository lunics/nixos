{ lib, ... }: with lib; {
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

    screen_locker = mkOption {
      type    = types.str;
      default = "hyprlock";
    };
  };
}
