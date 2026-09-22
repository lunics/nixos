{
  flake.aspects.pam.nixos = { config, lib, options, ... }: with lib;
  let
    has-u2f-keys = (options ? sops) && (config.sops.secrets ? "u2f-keys");
    u2f-keys     = config.sops.secrets."u2f-keys";    # lazy, only forced when has-u2f-keys
    u2f-authfile = if has-u2f-keys then u2f-keys.path else null;   # null makes pam_u2f fall back to $XDG_CONFIG_HOME/Yubico/u2f_keys
    # check if u2f-keys.mode = "0440"; or more. The lock screen reads the authfile unprivileged, a root only secret fails silently
    u2f-readable = u2f-keys.group == config._.sops-group && elem (substring 2 1 u2f-keys.mode) [ "4" "5" "6" "7" ];
  in {
    security.pam = {
      u2f = {
        enable  = has-u2f-keys;  # without the mapping file pam_u2f only fails silently
        control = "sufficient";  # required, requisite, sufficient, optional
        settings = {
          cue         = true;  # display a reminder message to touch the yubikey
          cue_prompt  = "Waiting for the Yubikey touch";
          interactive = false; # true waits for ENTER before probing the key, only useful without a tactile trigger
          # prompt    = "Insert your Yubikey, then press ENTER";   # interactive mode only
          debug       = false;
          appid       = "pam://${config._.hostname}";
          origin      = "pam://${config._.hostname}";
          authfile    = u2f-authfile;
          # authpending_file = "";
          pinverification = 0;
          userpresence = 1;
        };
      };
      services = {
        login = {
          # u2fAuth    = true;
          enableGnomeKeyring = true;    ## can be toggle if add option keyring = false
        };
        # u2fAuth is redundant, security.pam.u2f.enable already applies to every service
        # sudo.u2fAuth     = true;
        # swaylock.u2fAuth = true;
        # hyprlock.u2fAuth = true;
      };
    };

    assertions = optionals has-u2f-keys [{
      assertion = u2f-readable;
      message   = "sops: u2f-keys is ${u2f-keys.group} ${u2f-keys.mode}, it must be group ${config._.sops-group} and group readable";
    }];
  };
}
