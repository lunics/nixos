{ dns }: with dns.lib.combinators; {
  SOA = {
    nameServer = "ns1";
    adminEmail = "admin@example.com";
    serial = 2019030800;
  };
  useOrigin = false; # default value, see comment below.
  NS = [
    "ns1.example.com."
    "ns2.example.com."
  ];

  A = [ "203.0.113.1" ];
  AAAA = [ "4321:0:1:2:3:4:567:89ab" ];

  subdomains = rec {
    foobar = host "203.0.113.2" "4321:0:1:2:3:4:567:89bb";

    ns1 = foobar;
    ns2 = host "203.0.113.3" "4321:0:1:2:3:4:567:89cc";
  };
}
