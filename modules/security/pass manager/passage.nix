{
  flake.aspects = { aspects, ... }:{
    pass_manager = {
      includes = with aspects; [ age ];

      homeManager = { config, lib, pkgs, ... }:{
        config = lib.mkIf config._.passage {
          _.persistent-home.dirs = [ ".local/share/passage" ];    # the identities come from sops

          home = {
            packages = with pkgs; [
              passage
              oath-toolkit  # as a pass-otp replacement
              # age         # installed from system
              # rage        # //
            ];
            sessionVariables = rec {
              PASSWORD_STORE_DIR      = "${config._.local_share}/passage/store";   # for rofi-pass
              PASSAGE_DIR             = "${config._.local_share}/passage/store";
              PASSAGE_IDENTITIES_FILE = "${config._.dot_config}/age/identities";
              # PASSAGE_AGE             = "";   # IF rage
              PASSWORD_STORE_CLIP_TIME = "20";
            };
          };
        };
      };
    };
  };
}
