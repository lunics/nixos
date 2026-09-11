{
  flake.aspects.pam.nixos = { config, lib, options, ... }: with lib;
  let
    u2f-authfile = if (options ? sops) && (config.sops.secrets ? u2f_keys)
                   then config.sops.secrets.u2f_keys.path
                   else null;     # null makes pam_u2f fall back to $XDG_CONFIG_HOME/Yubico/u2f_keys
  in {
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
          cue_prompt  = "Waiting for the Yubikey touch";
          interactive = true;  # prompt before testing presence of U2F device, recommended if no tactile trigger
          prompt      = "Insert your Yubikey, then press ENTER";
          debug       = false;
          appid       = "pam://$HOSTNAME";
          origin      = "pam://$HOSTNAME";
          authfile    = u2f-authfile;
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

    assertions = optionals config.security.pam.u2f.enable [{
      assertion = u2f-authfile != null;
      message   = "sops: missing u2f_keys secret, pam_u2f would silently fall back to the per-user authfile";
    }];
  };
}
