{ config, lib, ... }: with lib; {
  options._ = {
    home = mkOption {
      type    = types.str;
      default = config.home.homeDirectory;
    };
    dot_config = mkOption {
      type    = types.str;
      default = config.xdg.configHome;
    };
    dot_cache = mkOption {
      type    = types.str;
      default = config.xdg.cacheHome;
    };
    local_state = mkOption {
      type    = types.str;
      default = config.xdg.stateHome;
    };
    local_share = mkOption {    # stay local
      type    = types.str;
      default = config.xdg.dataHome;
    };
    share = mkOption {          # on USB
      type    = types.str;
      default = config.xdg.dataHome;
    };
    downloads = mkOption {
      type    = types.str;
      default = "${config._.home}/downloads";
    };
    logs = mkOption {
      type    = types.str;
      default = "${config._.home}/.local/logs";
    };
  };
}
