{
  flake.aspects.desktop_nixos.nixos = { config, lib, pkgs, ... }: 
  let
    _ = config._;
  in {
    config = lib.mkIf (_.login_manager && _.wayland_user != "" && !_.headless){
      services.greetd = {
        enable = true;
        settings = rec {
          initial_session = {
            command = "${pkgs.hyprland}/bin/start-hyprland";
            # command = "${pkgs.uwsm}/bin/uwsm start hyprland-uwsm.desktop";
            user    = _.wayland_user;
          };
          default_session = initial_session;
        };
      };

      security.pam.services.greetd = {
        startSession = true;
        u2fAuth      = true;
      };

      # environment.etc."greetd/environments".text = "Hyprland"; ## try without and check journalctl -u greetd
    };
  };
}
