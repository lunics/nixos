{
  flake.aspects.yubikey.nixos = { config, pkgs, ... }:
  let
    key = config._.udev.yubikey;
  in {
    services.udev = {
      packages = [ pkgs.yubikey-personalization ];

      # lock every session when the key is unplugged
      extraRules = ''
        ACTION=="remove",\
          ENV{ID_BUS}=="usb",\
          ENV{ID_MODEL_ID}=="${key.id_model_id}",\
          ENV{ID_VENDOR_ID}=="${key.id_vendor_id}",\
          ENV{ID_VENDOR}=="${key.id_vendor}",\
          RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
      '';
    };
  };
}
