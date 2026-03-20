{ config, inputs, pkgs, ... }:{
  imports = [ inputs.wsl.nixosModules.default ];

  wsl = {
    enable                = config._.wsl;
    defaultUser           = "nixos";
    docker-desktop.enable = false;
    wslConf = {               #  /etc/wsl.conf: https://learn.microsoft.com/en-us/windows/wsl/wsl-config#configuration-settings-for-wslconf
      automount = {
        enabled    = true;    # auto mount windows drives under /mnt
        root       = "/mnt";
        ldconfig   = false;   # when using wsl.useWindowsDriver
        mountFsTab = false;   # useless, systemd will mount those for you
        options    = "metadata,uid=1000,gid=100";  # options for mounting windows drives
      };
      boot = {
        systemd = true;       # use systemd as init
        command = "";         # command to run when the distro is started
      };
      interop = {
        enabled = true;           # support running Windows binaries from the linux shell
        appendWindowsPath = true; # include the windows PATH in the PATH variable
      };
      network = {
        generateHosts      = true;  # generate /etc/hosts
        generateResolvConf = true;  # generate /etc/resolv.conf
        hostname           = config.networking.hostName;
      };
      user.default = "root";
    };
    interop = {
      includePath = true;     # add Windows PATH in WSL PATH
      register    = false;    # explicitly register the binfmt_misc handler for Windows executables
    };
    ssh-agent = {
      enable  = true;                 # enable ssh-agent passthrough to Windows
      package = pkgs.wsl2-ssh-agent;
      users   = "!@system";           # !@system, @system or a list of string
    };
    startMenuLaunchers = true;        # enable shortcuts for GUI applications in the windows start menu
    tarball.configPath = null;
    usbip = {
      enable           = false;
      autoAttach       = [];
      snippetIpAddress = "192.168.1.1";
    };
    useWindowsDriver = false;         # enable OpenGL driver from the Windows host
    wrapBinSh = true;                 # takes only effect when using native systemd
  };
}
