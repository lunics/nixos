{
  flake.aspects.dns.nixos = { config, ... }: {
    networking.extraHosts = config._.dns.etc_hosts;

    networking.hosts = {   # alternative
      # "192.168.1.35" = [ "hostname-A" ];
    };
  };
}
