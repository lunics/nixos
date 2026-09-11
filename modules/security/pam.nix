{
  flake.aspects.pam.nixos = { config, lib, ... }: with lib; {
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
          authfile    = config._.u2f_keys;   # null keeps the pam_u2f default location
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

    assertions = optionals (config._.u2f_keys != null) [{
      assertion = config.sops.secrets ? u2f_keys;
      message   = "sops: missing u2f_keys secret";
    }];
  };
}
