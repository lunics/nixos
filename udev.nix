{
  services.udev = {
    enable = true;
    extraRules = ''
      ACTION=="add", 
      SUBSYSTEM=="block", 
      ENV{ID_FS_UUID}=="0543f662-b81a-484e-9c52-71b6142685b2",
      RUN+="/home/lunics/usb_copy/homelab/nixos/user/shell/scripts/test.sh"
    '';
}
