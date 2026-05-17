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
            # command = "${pkgs.hyprland}/bin/Hyprland";
            command = "${pkgs.uwsm}/bin/uwsm start hyprland-uwsm.desktop";
            user    = _.wayland_user;
          };
          default_session = initial_session;
        };
      };

      environment.etc."greetd/environments".text = "Hyprland";
    };
  };
}
