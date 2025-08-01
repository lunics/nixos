{ lib, ... }:{
  security.sudo-rs = {
    enable             = true;
    execWheelOnly      = lib.mkDefault true;  # only allow members of the wheel group to execute sudo, prevents users that are not members of wheel from exploiting vulnerabilities in sudo such as CVE-2021-3156
    wheelNeedsPassword = lib.mkDefault true;  # users of the wheel group must provide a password to run commands
    defaultOptions = [
      "SETENV"
    ];
    configFile  = "";    # contents of the sudoers file
    extraConfig = "";
    extraRules  = [];
  };
}
