{
  flake.aspects.yubikey.nixos = { config, lib, ... }: with lib;
  let
    # clan returns /no-such-path for a generator declared but not yet imported, sops then takes over
    clan-keys    = config.clan.core.vars.generators.u2f-keys.files.keys or null;
    sops-keys    = config.sops.secrets."u2f-keys" or null;
    u2f-keys     = if clan-keys != null && clan-keys.path != "/no-such-path" then clan-keys else sops-keys;
    has-u2f-keys = u2f-keys != null;
    u2f-authfile = if has-u2f-keys then u2f-keys.path else null;   # null makes pam_u2f fall back to $XDG_CONFIG_HOME/Yubico/u2f_keys
    # check if u2f-keys.mode = "0440"; or more. The lock screen reads the authfile unprivileged, a root only secret fails silently
    u2f-readable = has-u2f-keys && u2f-keys.group == config._.sops-group && elem (substring 2 1 u2f-keys.mode) [ "4" "5" "6" "7" ];
  in {
    security.pam.u2f = {
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

    assertions = optionals has-u2f-keys [{
      assertion = u2f-readable;
      message   = "u2f-keys is ${u2f-keys.group} ${u2f-keys.mode}, it must be group ${config._.sops-group} and group readable";
    }];
  };
}
