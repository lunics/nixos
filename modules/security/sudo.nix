{
  flake.aspects.security.nixos = { config, lib, ... }:{
    security.sudo-rs = {
      enable             = true;
      execWheelOnly      = lib.mkDefault true;  # prevents non-wheel users from exploiting sudo vulnerabilities (eg CVE-2021-3156)
      wheelNeedsPassword = lib.mkDefault true;
      defaultOptions     = [ "SETENV" ];
      configFile         = "";    # contents of the sudoers file
      extraConfig        = "";
      extraRules = [
        {
          users    = [ config._.user ];
          host     = "ALL";
          runAs    = "ALL:ALL";
          commands = map (cmd: {
            command = cmd;
            options = [ "NOPASSWD" ];
          }) config._.sudo.no_passwd;
        }
      ];
    };
  };
}
