{ config, lib, ... }: with lib; {
  options._ = {
    home_studio = mkEnableOption "";

    musescore = {
      share = mkOption {
        type    = types.str;
        default = "${config._.local_share}/MuseScore";
      };

      client_id = mkOption {
        type    = types.str;
        default = "";
      };
    };
  };
}
