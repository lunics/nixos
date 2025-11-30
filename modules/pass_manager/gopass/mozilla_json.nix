{ config, lib, ... }:{
  config = lib.mkIf (config._.pass_manager == "gopass") {
    # old REMOVE if OK "path":        "${config._.dot_config}/gopass/gopass_wrapper.sh",
    home.file.".mozilla/native-messaging-hosts/com.justwatch.gopass.json".text = ''
      {
        "name":        "com.justwatch.gopass",
        "description": "Gopass wrapper to search and return passwords",
        "path":        "${./gopass_wrapper.sh}",
        "type":        "stdio",
        "allowed_extensions": [
          "{eec37db0-22ad-4bf1-9068-5ae08df8c7e9}"
        ]
      }
    '';
  };
}
