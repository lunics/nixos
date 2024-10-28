{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "Hyprland";
        user    = "***REMOVED***"; };
      default_session = initial_session;
    };
  };

  environment.etc."greetd/environments".text = "Hyprland";
}
