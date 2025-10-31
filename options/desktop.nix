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
  };
}
