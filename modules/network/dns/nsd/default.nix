{ config, lib, ... }:{
  config = lib.mkIf config._.dns.nsd {
    services.nsd = {
      enable            = true;
      zones             = {};

      zonefilesWrite    = 0;
      zonefilesCheck    = true;     # check mtime of all zone files on start and sighup
      roundRobin        = false;    # enable round robin rotation of records

      identity          = "unidentified server";   # Identify the server (CH TXT ID.SERVER entry).
      extraConfig       = "";
      hideVersion       = true;
      version           = null;     # version string replied for CH TXT

      ipv4              = true;
      ipv6              = true;
      interfaces = [                # addresses the server should listen to
        "127.0.0.0"
        "::1"
      ];
      ipv4EDNSSize      = 4096;     # preferred EDNS buffer size for IPv4 
      ipv6EDNSSize      = 4096;
      port              = 53;
      # reuseport = pkgs.stdenv.hostPlatform.isLinux;

      keys              = {};       # TSIG keys
      dnssecInterval    = "1h";     # how often to check whether dnssec key rollover is required

      nsid              = null;     # NSID identity
      xfrdReloadTimeout = 1;        # seconds between reloads triggered by xfrd
      tcpTimeout        = 120;
      tcpQueryCount     = 0;        # 0 = no maximum
      tcpCount          = 100;      # number of concurrent TCP connections per server
      ipFreebind        = false;
      ipTransparent     = false;
      verbosity         = 0;        # verbosity level
      logTimeAscii      = true;     # log time in ascii, if false then in unix epoch seconds
      statistics        = null;     # null = no statistics logged
      serverCount       = 1;        # NSD servers to fork, put the number of CPUs to use here
      bind8Stats        = false;    # enable BIND8 like statistics
      rootServer        = false;    # this server will be a root server
    };
  };
}
