{
  services.crowdsec = {
    enable        = true;
    enrollKeyFile = "/path/to/enroll-key";

    settings = {
      api.server = {
        listen_uri = "127.0.0.1:8080";
      };
  };
}
