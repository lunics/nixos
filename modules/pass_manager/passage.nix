{ config, lib, pkgs, ... }: with lib; {
  config = mkMerge [
    (mkIf config._.passage {
      home = {
        packages = with pkgs; [
          passage
          oath-toolkit  # as a pass-otp replacement
          # age         # installed from system
          # rage        # //
        ];

        sessionVariables = rec {
          PASSWORD_STORE_DIR      = "${config._.share}/passage/store";   # for rofi-pass
          PASSAGE_DIR             = "${config._.share}/passage/store";
          PASSAGE_IDENTITIES_FILE = "${config._.dot_config}/age/identities";
          # PASSAGE_AGE             = "";   # IF rage
          PASSWORD_STORE_CLIP_TIME = "20";
        };
      };
    })
    (mkIf (config._.passage && (config._.age_identities != null )){
      home.file.".config/age/identities".source = config._.age_identities;
    })
  ];
}
