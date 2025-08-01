{ config, lib, ... }:{
  config = lib.mkIf (config._.login_manager && config._.wayland_user != "") {
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "Hyprland";
          user    = config._.wayland_user; };
        default_session = initial_session;
      };
      vt = 1;   # tty that greetd should use
    };

    environment.etc."greetd/environments".text = "Hyprland";
  };
}
