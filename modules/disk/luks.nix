{ config, lib, ... }:let 
  _ = config._.disk; 
in {
  config = lib.mkIf _.luks {
    disko.devices.disk.${_.device}.content.partitions = {
      luks = {
        size    = "100%";
        label   = "luks";
        content = {
          type          = "luks";
          name          = "luks";
          extraOpenArgs = [
            "--allow-discards"
            "--perf-no_read_workqueue"
            "--perf-no_write_workqueue" 
          ];
          settings = {    
            # https://0pointer.net/blog/unlocking-luks2-volumes-with-tpm2-fido2-pkcs11-security-hardware-on-systemd-248.html
            # KO BREAKS LUKS on nixos-anywhere ??
            # crypttabExtraOpts = [ 
            #   "fido2-device=auto" 
            #   "token-timeout=10" 
            # ];

            # keyFile = "/tmp/secret.key";          # disable passwordFile if you want to use keyFile
            # passwordFile = "/tmp/secret.key";     # disable settings.keyFile if you want to use interactive password entry
            # allowDiscards = true;       # improves performance on SSD storage but has security implications
          };
          # additionalKeyFiles = [ "/tmp/additionalSecret.key" ];
        };
      };
    };
  };
}
