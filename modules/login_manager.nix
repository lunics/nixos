{ config, lib, ... }:{
  config = lib.mkIf config._login_manager {
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "Hyprland";
          user    = "lunics"; };
        default_session = initial_session;
      };
    };

    environment.etc."greetd/environments".text = "Hyprland";
  };
}
