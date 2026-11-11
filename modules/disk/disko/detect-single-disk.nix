{
  flake.aspects.disk.nixos = { config, lib, ... }: with lib;
  let
    # internal disks of the facter report, the usb live media is left out
    disks = filter (disk: ! elem (disk.driver or "") ["usb-storage" "uas"])
      (config.hardware.facter.report.hardware.disk or []);
    by-id = disk: findFirst (hasPrefix "/dev/disk/by-id/") null (disk.unix_device_names or []);
  in {
    _.disk.device-by-id = mkDefault (
      if
        length disks == 1 && by-id (head disks) != null then by-id (head disks)
      else throw
        "_.disk.device-by-id: the facter report holds ${toString (length disks)} internal disks, set it by hand"
    );
  };
}
