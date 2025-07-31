{ config, lib, ... }:{
  config = lib.mkIf config._.login_manager {
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "Hyprland";
          user    = "lunics"; };
        default_session = initial_session;
      };
      vt = 1;   # tty that greetd should use
    };

    environment.etc."greetd/environments".text = "Hyprland";
  };
}
