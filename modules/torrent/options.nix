{
  flake.aspects.options.vars = { config, lib, ... }: with lib; {
    options._ = {
      torrents_dir = mkOption {
        type    = types.str;
        default = "${config._.downloads}/torrents";
      };

      rtorrent = mkEnableOption "";
    };
  };
}
