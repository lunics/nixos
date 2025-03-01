{
  services = {
    udiskie = {
      enable    = true;
      automount = true;
      notify    = true;
      tray      = "auto";  # auto, always, never
    };

  systemd.user.services."my-luks-mount" = {
    name        = "my-luks-mount";
    description = "Run script after LUKS partition is mounted";
    after       = ["dev-disk-by\x2duuid-0543f662-b81a-484e-9c52-71b6142685b2.device"];
    requires    = ["dev-disk-by\x2duuid-0543f662-b81a-484e-9c52-71b6142685b2.device"];

    serviceConfig = {
      Type      = "oneshot";
      # ExecStart = "${pkgs.bash}/bin/bash /path/to/your/script.sh";
      ExecStart = "/home/lunics/usb_copy/homelab/nixos/user/shell/scripts/test.sh";
      RemainAfterExit = true;
    };

    WantedBy = "multi-user.target";
  };
}
