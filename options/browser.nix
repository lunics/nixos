{ lib, ... }: with lib; {
  options._ = {
    browser = mkOption {
      type    = types.str;
      default = "zen";
    };
    firefox= {
      path = mkOption {
        type    = types.str;
        default = "~/.mozilla/firefox";
      };
      containers = mkOption {
        type    = types.listOf types.str;
        default = [];
      };
    };
  };
}
