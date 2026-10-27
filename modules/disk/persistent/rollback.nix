{
  flake.aspects.persistent.nixos = { config, lib, ... }: with lib;
  let
    subvolumes  = [ "root" ];
    keep-days   = 30;                                       # archives older than this are deleted
    device      = "/dev/disk/by-label/NIXOS";               # btrfs label, the same with or without luks
    device-unit = "dev-disk-by\\x2dlabel-NIXOS.device";
  in {
    config = mkIf (config._.persistent && config._.persistent-system.rollback) {
      boot.initrd.supportedFilesystems.btrfs = true;

      # archive each subvolume and recreate it empty, before / is mounted
      boot.initrd.systemd.services.rollback = {
        description = "Archive the ephemeral subvolumes and recreate them empty";
        wantedBy    = [ "initrd.target" ];
        requires    = [ device-unit ];
        after       = [ device-unit ];
        before      = [ "sysroot.mount" ];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = ''
          mkdir -p /btrfs
          mount -t btrfs -o subvolid=5 ${device} /btrfs
          cutoff=$(date -d "-${toString keep-days} days" +%s)

          for subvol in ${concatStringsSep " " subvolumes}; do
            archives=/btrfs/old-roots/$subvol
            mkdir -p $archives

            if [ -e /btrfs/$subvol ]; then
              mv /btrfs/$subvol $archives/$(date +%Y-%m-%dT%H:%M:%S)
            fi

            for old in $archives/*; do
              [ -e "$old" ] || continue
              if [ "$(date -d "$(basename "$old")" +%s)" -lt "$cutoff" ]; then
                btrfs subvolume delete --recursive "$old"
              fi
            done

            btrfs subvolume create /btrfs/$subvol
          done

          umount /btrfs
        '';
      };
    };
  };
}
