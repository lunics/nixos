{
  # KO because of \x
  # { lib, ... }:{
  # systemd.user.services."my-luks-mount" = {
  #   name        = "my-luks-mount";
  #   description = "Run script after LUKS partition is mounted";
    
  #   after       = lib.concatStrings ["run-media-lunics-0543f662i" "x2db81a\\" "x2d484e\\" "x2d9c52\\" "x2d71b6142685b2.mount"];
  #   # requires    = ["run-media-lunics-0543f662\x2db81a\x2d484e\x2d9c52\x2d71b6142685b2.mount"];
  #   # after       = ["/run/media/lunics/0543f662-b81a-484e-9c52-71b6142685b2"];
  #   # requires    = ["/dev/disk/by-uuid/0543f662-b81a-484e-9c52-71b6142685b2"];
  #   # after       = ["/dev/disk/by-uuid/0543f662-b81a-484e-9c52-71b6142685b2"];

  #   serviceConfig = {
  #     Type      = "oneshot";
  #     # ExecStart = "${pkgs.bash}/bin/bash /path/to/your/script.sh";
  #     ExecStart = "/home/lunics/usb_copy/homelab/nixos/user/shell/scripts/test.sh";
  #     RemainAfterExit = true;
  #   };

  #   # wantedBy       = ["run-media-lunics-0543f662i\\" + "x2db81a\\" + "x2d484e\\" + "x2d9c52\\" + "x2d71b6142685b2.mount"];
  # };
}
