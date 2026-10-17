{
  # always unsealed instance providing transit auto-unseal to other vaults
  flake.aspects.openbao-unsealer.nixos = { config, pkgs, ... }:
  let
    ip     = config._.net.addr.ipv4;
    creds  = "/run/credentials/openbao.service";
    policy = pkgs.writeText "autounseal.hcl" ''
      path "transit/encrypt/autounseal" { capabilities = ["update"] }
      path "transit/decrypt/autounseal" { capabilities = ["update"] }
    '';
    # native hcl: the json settings sort keys and break the request order
    self-init = pkgs.writeText "self-init.hcl" ''
      initialize "unsealer" {
        request "enable-transit" {
          operation = "update"
          path      = "sys/mounts/transit"
          data      = { type = "transit" }
        }
        request "autounseal-key" {
          operation = "update"
          path      = "transit/keys/autounseal"
          data      = { type = "aes256-gcm96" }
        }
        request "autounseal-policy" {
          operation = "update"
          path      = "sys/policies/acl/autounseal"
          data      = {
            policy = { eval_type = "string", eval_source = "file", path = "${policy}" }
          }
        }
        request "autounseal-token" {
          operation = "update"
          path      = "auth/token/create-orphan"
          data      = {
            id           = { eval_type = "string", eval_source = "file", path = "${creds}/openbao-autounseal-token" }
            policies     = ["autounseal"]
            period       = "168h"
            display_name = "autounseal"
          }
        }
      }

      initialize "admin" {
        request "admin-token" {
          operation = "update"
          path      = "auth/token/create-orphan"
          data      = {
            id           = { eval_type = "string", eval_source = "file", path = "${creds}/openbao-admin-token" }
            policies     = ["root"]
            display_name = "admin"
          }
        }
      }
    '';
  in {
    assertions = [{
      assertion = ip != "";
      message   = "openbao-unsealer needs a static _.net.addr.ipv4 for api_addr and cluster_addr";
    }];

    services.openbao = {
      enable    = true;
      package   = pkgs.openbao;
      extraArgs = [ "-config" "${self-init}" ];   # runs once on empty storage, root token revoked
      settings  = {                               # freeform, see https://openbao.org/docs/configuration
        ui = true;

        listener.default = {
          type        = "tcp";                    # tcp, unix
          address     = "0.0.0.0:8200";
          tls_disable = true;
          # tls_acme_email   = config.security.acme.defaults.email;
          # tls_acme_domains = [ "example.com" ];
          # tls_acme_disable_http_challenge = true;
        };

        api_addr     = "http://${ip}:8200";
        cluster_addr = "http://${ip}:8201";

        seal.static = {                           # unseals itself on boot
          current_key_id = "1";
          current_key    = "file://${creds}/openbao-unseal-key";
        };

        storage.raft.path = "/var/lib/openbao";
      };
    };

    # DynamicUser unit: secrets come in as systemd credentials, token ids must not contain "."
    systemd.services.openbao.serviceConfig.ImportCredential = [
      "openbao-unseal-key"
      "openbao-autounseal-token"
      "openbao-admin-token"
    ];

    networking.firewall.allowedTCPPorts = [ 8200 ];                 # openbao api
    environment.variables.BAO_ADDR      = "http://127.0.0.1:8200";  # the cli defaults to https
  };
}
