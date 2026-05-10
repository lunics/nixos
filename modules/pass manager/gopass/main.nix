{
  flake.aspects.pass_manager.homeManager = { config, lib, ... }: with lib; {
    config = mkMerge [
      (mkIf (config._.pass_manager == "gopass") {
        # sessionVariables.PASSWORD_STORE_DIR = "${config._.share}/gopass";   # for rofi-pass
      })
      (mkIf (config._.pass_manager == "gopass" && (config._.age_identities != null )){
        home.file.".config/age/identities".source = config._.age_identities;
      })
    ];
  };
}
