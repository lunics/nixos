{
  services.udiskie = {
    enable    = true;
    settings = {
      program_options = {
        # udisks_version = 2;
        automount = true;
        notify    = true;
        tray      = "auto";  # auto, always, never
      };
      icon_names.media = [ "media-optical" ];
      # device_config = [
      #   {
      #     # "id_uuid" = [ "f03d5303-948c-4842-934c-727cbc5039be" ];           KO
      #     # "id_type" = "crypto_LUKS";                                        KO
      #     # "device_file"= "/org/freedesktop/UDisks2/block_devices/sda";      KO
      #     # "device_file"= "/org/freedesktop/UDisks2/block_devices/dm_2d1";   KO
      #     # options = [ "noexec" "nodev" ];
      #     automount = true;
      #     mount_path = "/mnt/teest";
      #   }
      # ];
    };
  };
}
