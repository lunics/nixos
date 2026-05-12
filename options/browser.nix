{
  flake.aspects.options.generic = { config, lib, ... }: with lib; {
    options._ = {
      browser = mkOption {
        type    = types.str;
        default = "firefox";
      };
      firefox= {
        path = mkOption {
          type    = types.str;
          default = "${config._.dot_config}/mozilla/firefox";  # "~/.mozilla/firefox";
        };
        containers = mkOption {
          type    = types.listOf types.str;
          default = [];
        };
        profile_on_ram = mkEnableOption "";
      };
    };
  };
}
