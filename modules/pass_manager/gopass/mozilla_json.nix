{ config, lib, pkgs, ... }:{
  config = lib.mkIf (config._.pass_manager == "gopass") {
    xdg.configFile."mozilla/native-messaging-hosts/com.justwatch.gopass.json".text = ''
      {
        "name":        "com.justwatch.gopass",
        "description": "Gopass wrapper to search and return passwords",
        "path":        "${pkgs.gopass_wrapper}/bin/gopass_wrapper",
        "type":        "stdio",
        "allowed_extensions": [
          "{eec37db0-22ad-4bf1-9068-5ae08df8c7e9}"
        ]
      }
    '';
  };
}
