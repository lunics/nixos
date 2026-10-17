{
  flake.aspects = { aspects, ... }:{
    openbao.nixos = { config, pkgs, ... }:{
      services.openbao = {
        enable    = true;
        package   = pkgs.openbao;
        extraArgs = [];                       # additional arguments given to `bao server`
        settings  = {                         # freeform, see https://openbao.org/docs/configuration
          ui = true;

          listener.default = {
            type    = "tcp";
            address = "127.0.0.1:8200";       # default for unix: /run/openbao/openbao.sock
            tls_disable = true;
            # tls_acme_email   = config.security.acme.defaults.email;
            # tls_acme_domains = [ "example.com" ];
            # tls_acme_disable_http_challenge = true;
          };

          cluster_addr = "http://127.0.0.1:8201";
          api_addr     = "http://127.0.0.1:8200";

          storage.raft.path = "/var/lib/openbao";
        };
      };
    };
  };
}
