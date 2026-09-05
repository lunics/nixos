{
  flake.aspects = {
    options.generic = { lib, ... }: with lib; {
      options._.audio-mixer-fix = mkOption {
        type    = types.str;
        default = "";      # ignore-db, soft
      };
    };

    audio.nixos = { config, lib, ... }: with lib;
    let
      fix = config._.audio-mixer-fix;
    in mkIf (fix != "") {
      services.pipewire.wireplumber.extraConfig."51-alsa-mixer-fix" = {
        "monitor.alsa.rules" = [
          {
            matches = [ { "device.name" = "~alsa_card.*"; } ];
            actions.update-props = optionalAttrs (fix == "ignore-db") {
              "api.alsa.ignore-dB" = true;
            } // optionalAttrs (fix == "soft") {
              "api.alsa.soft-mixer" = true;
            };
          }
        ];
      };
    };
  };
}
