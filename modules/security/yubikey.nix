{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      yubikey = mkEnableOption "";

      udev.yubikey = {
        id_model_id = mkOption {
          type    = types.str;
          default = "0407";
        };
        id_vendor_id = mkOption {
          type    = types.str;
          default = "1050";
        };
        id_vendor = mkOption {
          type    = types.str;
          default = "Yubico";
        };
      };
    };
  };

  flake.aspects.yubikey.nixos = { config, pkgs, ... }:
  let
    key = config._.udev.yubikey;
  in {
    _.yubikey = true;

    environment.systemPackages = with pkgs; [
      yubikey-manager
      yubikey-touch-detector
      yubikey-agent         # ssh-agent for yubikey
      yubico-pam
      pam_u2f
      age-plugin-yubikey
      pcsclite
      yubikey-personalization
      # yubikey-full-disk-encryption
    ];

    services = {
      pcscd.enable         = true;
      udev.packages        = [ pkgs.yubikey-personalization ];
      yubikey-agent.enable = true;  # install the service in user space, every session requires PIN, every login requires touch

      # lock every session when the key is unplugged
      udev.extraRules = ''
        ACTION=="remove",\
          ENV{ID_BUS}=="usb",\
          ENV{ID_MODEL_ID}=="${key.id_model_id}",\
          ENV{ID_VENDOR_ID}=="${key.id_vendor_id}",\
          ENV{ID_VENDOR}=="${key.id_vendor}",\
          RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
      '';
    };

    programs.yubikey-touch-detector = {
      enable     = true;
      libnotify  = true;   # send a desktop notification on touch request
      unixSocket = true;   # expose the notifications on a unix socket
      verbose    = false;
    };

    # programs = {
    #   ssh.startAgent = false;
    #   gnupg.agent = { enable = true; enableSSHSupport = true; };
    # };
  };
}
