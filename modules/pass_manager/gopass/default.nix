{ config, lib, ... }: with lib; {
  imports = [ 
    ./packages.nix
    ./config.nix
    ./mozilla_json.nix
    ./gopass_wrapper.nix
    ./gopass_completion.nix
  ];

  config = mkMerge [
    (mkIf (config._.pass_manager == "gopass") {
      # sessionVariables.PASSWORD_STORE_DIR = "${config._.share}/gopass";   # for rofi-pass
    })
    (mkIf (config._.pass_manager == "gopass" && (config._.age_identities != null )){
      home.file.".config/age/identities".source = config._.age_identities;
    })
  ];
}
