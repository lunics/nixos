{
  flake.aspects.crowdsec.nixos = {
    services.crowdsec = {
      enable        = true;
      enrollKeyFile = "/path/to/enroll-key";
      settings = {
        api.server.listen_uri = "127.0.0.1:8080";
      };
    };

    _.persistent-system.dirs = [
      "/var/lib/crowdsec"    # local api database, machine credentials and the installed hub items
    ];
  };
}
