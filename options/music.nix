{ config, lib, ... }: with lib; {
  options._ = {
    home_studio = mkEnableOption "";

    musescore_share = mkOption {
      type    = types.str;
      default = "${config._.local_share}/MuseScore";
    };

    musescore_client_id = mkOption {
      type    = types.str;
      default = "";
    };
  };
}
