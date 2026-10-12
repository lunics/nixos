{
  flake.aspects.nftables.nixos = { config, ... }:{
    key = "aspects/nftables";

    networking.nftables = {
      enable                = true;       # blacklists ip_tables, docker/libvirt still load it
      checkRuleset          = true;       # nft --check the ruleset in the build sandbox
      checkRulesetRedirects = {           # paths rewritten by libredirect during the check
        "/etc/hosts"     = config.environment.etc.hosts.source;
        "/etc/protocols" = config.environment.etc.protocols.source;
        "/etc/services"  = config.environment.etc.services.source;
      };
      preCheckRuleset       = "";         # script run before the check, e.g. sed on ruleset.conf
      # flushRuleset        = false;      # module mkDefault: true when ruleset/rulesetFile is set
      extraDeletions        = "";         # run on every start, reload and stop
      ruleset               = "";         # loaded with nft -f, updated atomically
      rulesetFile           = null;
      flattenRulesetFile    = false;      # readFile instead of include, lets preCheckRuleset apply
      tables                = {};         # each table is deleted before every update
      # tables.filter = {
      #   enable  = true;
      #   family  = "inet";               # ip, ip6, inet, arp, bridge, netdev
      #   content = ''
      #     chain input {
      #       type filter hook input priority 0;
      #       iifname lo accept
      #       ct state {established, related} accept
      #       tcp dport 22 accept
      #       counter drop
      #     }
      #   '';
      # };
    };
  };
}
