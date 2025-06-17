{
  security.sudo-rs = {
    enable             = true;
    execWheelOnly      = true;         # only allow members of the wheel group to execute sudo, prevents users that are not members of wheel from exploiting vulnerabilities in sudo such as CVE-2021-3156
    wheelNeedsPassword = true;    # users of the wheel group must provide a password to run commands
    # configFile = '''';          # contents of the sudoers file
    defaultOptions = [
      "SETENV"
    ];
    extraConfig = "";
    # extraRules = {
    #   # rule_name = {
    #   #     commands = 
    #   #     groups   = 
    #   #     users    = 
    #   #     host     = "ALL";
    #   #     runAs    = "ALL:ALL";
    #   # };
    # };
  };
}
