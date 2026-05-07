{
  flake.aspects.services.nixos = { pkgs, ... }:{
    systemd.services."no-wakeup" = {
      description = "disable XHCI to prevent the system from waking up";
      after       = [ "multi-user.target" ];
      wantedBy    = [ "multi-user.target" ];
      serviceConfig = {
        Type      = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c \"grep -q 'XHCI.*enabled' /proc/acpi/wakeup && echo XHCI > /proc/acpi/wakeup || true\"";
      };
    };
  };
}
