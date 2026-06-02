{
  flake.aspects.logind.nixos = { config, ... }:{
    services.logind.settings.Login = {
      RuntimeDirectorySize   = "4G";
        # Change runtime directory size. automatically systemd managed per-user directory more secure than /tmp
        # limit $XDG_RUNTIME_DIR=/run/user/1000 to 8 GB max; check with: df -h /run/user/1000
        # tmpfs is limited to half of your ram by default, but each tmpfs mounting can be customized

      # ignore, poweroff, reboot, halt, kexec, suspend, hibernate, hybrid-sleep, suspend-then-hibernate, sleep, lock
      # LidSwitch              = config._.laptop_lid;      
      # LidSwitchDocked        = "ignore";            # when the laptop lid is closed and another screen is added
      # LidSwitchExternalPower = config._.laptop_lid; # when the laptop lid is closed and the system is on external power
      # HibernateKey           = "hibernate";
      # HibernateKeyLongPress  = "ignore";
      # KillUserProcesses      = false;               # kill users processes when the they logs out
      # PowerKey               = "poweroff";          # when the power key is pressed
      # PowerKeyLongPress      = "ignore";
      # SuspendKey             = "suspend";
      # SuspendKeyLongPress    = "hibernate";         # when the suspend key is long-pressed
      # RebootKey              = "reboot";
      # RebootKeyLongPress     = "poweroff";
    };
  };
}
