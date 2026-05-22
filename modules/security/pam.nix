{
  flake.aspects.pam.nixos = { config, lib, ... }: with lib; {
    config = mkMerge [
      {
        security.pam = {
          # FIXME: create an authorization mapping file for your user (https://nixos.wiki/wiki/Yubikey#pam_u2f)
          # src
          #   https://developers.yubico.com/pam-u2f/
          #   https://developers.yubico.com/pam-u2f/Manuals/pam_u2f.8.html
          u2f = {
            enable  = true;
            control = "sufficient"; # required, requisite, sufficient, optional
            settings = {
              cue         = true;  # display a reminder message to touch the yubikey
              interactive = true;  # prompt before testing presence of U2F device, recommended if no tactile trigger
              debug       = false;
              appid       = "pam://$HOSTNAME";
              origin      = "pam://$HOSTNAME";
              # authpending_file = "";
              # pinverification = 1;
              userpresence = 1;
            };
          };
          services = {
            login = {
              # u2fAuth    = true;
              enableGnomeKeyring = true;    ## can be toggle if add option keyring = false
            };
            sudo.u2fAuth             = true;
            swaylock.u2fAuth         = true;
            # hyprlock.u2fAuth       = true;
          };
        };
      }
      (mkIf (config._.u2f_keys != "") {
        security.pam.u2f.settings.authfile = config._.u2f_keys;
      })
    ];
  };
}
