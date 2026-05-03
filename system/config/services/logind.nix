{ config, ... }:{
  services.logind = rec {
    extraConfig = "RuntimeDirectorySize=4G";  # 4G or 10% work
      # Change runtime directory size. automatically systemd managed per-user directory more secure than /tmp
      # limit $XDG_RUNTIME_DIR=/run/user/1000 to 8 GB max; check with: df -h /run/user/1000
      # tmpfs is limited to half of your ram by default, but each tmpfs mounting can be customized

    # ignore, poweroff, reboot, halt, kexec, suspend, hibernate, hybrid-sleep, suspend-then-hibernate, sleep, lock
    lidSwitch              = config._.laptop_lid;      
    lidSwitchDocked        = "ignore";            # when the laptop lid is closed and another screen is added
    lidSwitchExternalPower = config._.laptop_lid; # when the laptop lid is closed and the system is on external power
    hibernateKey           = "hibernate";
    hibernateKeyLongPress  = "ignore";
    killUserProcesses      = false;               # kill users processes when the they logs out
    powerKey               = "poweroff";          # when the power key is pressed
    powerKeyLongPress      = "ignore";
    suspendKey             = "suspend";
    suspendKeyLongPress    = "hibernate";         # when the suspend key is long-pressed
    rebootKey              = "reboot";
    rebootKeyLongPress     = "poweroff";
  };
}
