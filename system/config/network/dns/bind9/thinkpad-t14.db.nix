{ config, lib, ... }:{
  config = lib.mkIf config._.dns.bind9 {
    environment.etc."bind/zones/thinkpad-t14.db".text = ''
      $TTL    3600
      $ORIGIN thinkpad-t14.

      @       IN      SOA     ns1.thinkpad-t14. admin.thinkpad-t14. (
                     2025080100         ; Serial
                          21600         ; Refresh (6 hours)
                           3600         ; Retry  (1 hour)
                        3600000         ; Expire (5 weeks 6 days 16 hours)
                          3600 )        ; Negative Cache TTL (1 hour)

      @       IN      NS      ns1.thinkpad-t14.
      ns1     IN      A       192.168.1.101
      www     IN      A       192.168.1.102
    '';
  };
}
