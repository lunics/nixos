{
  flake.aspects.persistent.nixos =
  let
    device      = "/dev/disk/by-label/NIXOS";               # btrfs label, the same with or without luks
    device-unit = "dev-disk-by\\x2dlabel-NIXOS.device";
  in {
    # applies the requests written by persistent-restore, nothing is bind mounted on the persistent subvolumes yet
    # each request is a file in /mnt/snapshots/restore holding "<subvolume relative to the top level> <snapshot name>"
    # journalctl -b -u persistent-restore
    boot.initrd.systemd.services.persistent-restore = {
      description = "Replace the persistent subvolumes by the requested snapshots";
      wantedBy    = [ "initrd.target" ];
      requires    = [ device-unit ];
      after       = [ device-unit "ephemeral-btrfs.service" ];   # both mount the top level on /btrfs
      before      = [ "sysroot.mount" ];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = ''
        mkdir -p /btrfs
        mount -t btrfs -o subvolid=5 ${device} /btrfs

        for request in /btrfs/snapshots/restore/*; do
          [ -e "$request" ] || continue
          read -r subvol snapshot < "$request" || true             # no trailing newline makes read fail, fatal under bash -e
          source=/btrfs/snapshots/btrbk/$snapshot

          if [ -d "$source" ] && [ -n "$subvol" ]; then
            # the current state is kept next to it for a rollback, deleted by hand once the restore is checked
            if [ -e "/btrfs/$subvol" ]; then
              mv "/btrfs/$subvol" "/btrfs/$subvol.old-$(date +%Y%m%dT%H%M%S)"
            fi
            btrfs subvolume snapshot "$source" "/btrfs/$subvol"   # writable, the received snapshot stays a parent for btrbk
            echo "restored /$subvol from $snapshot"
          else
            echo "skipped $request: no snapshot $source" >&2
          fi
          rm "$request"                                           # applied once, never again at the next boot
        done

        umount /btrfs
      '';
    };
  };
}
