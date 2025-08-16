{ lib, ... }: with lib; {
  options._ = {
    status_bar = mkOption {
      type    = types.str;
      default = "waybar";
    };

    notifier = mkOption {
      type    = types.str;
      default = "dunst";
    };
  };
}
