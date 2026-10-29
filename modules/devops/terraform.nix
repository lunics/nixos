{
  flake.aspects.devops.homeManager = { config, lib, pkgs, ... }:
  let
    token-dir = "${config._.local_share}/openbao";

    # keeps the token in a persisted directory, the default ~/.vault-token is replaced by rename and can't be bind mounted
    token-helper = pkgs.writeShellScript "bao-token-helper" ''
      case "$1" in
        get)   cat ${token-dir}/token 2>/dev/null || true ;;
        store) umask 077; mkdir -p ${token-dir}; cat > ${token-dir}/token.tmp && mv ${token-dir}/token.tmp ${token-dir}/token ;;
        erase) rm -f ${token-dir}/token ;;
      esac
    '';
  in {
    config = lib.mkIf config._.terraform {
      _.persistent-home.dirs = [
        ".terraform.d"                                            # tofu login credentials
        { directory = ".local/share/openbao"; mode = "0700"; }    # bao token, through the token helper
      ];

      xdg.configFile."openbao/config.hcl".text = ''
        token_helper = "${token-helper}"
      '';

      home = {
        packages = with pkgs; [
          opentofu
          openbao       # free fork of vault, the cli is bao and still reads the VAULT_* variables
          # tofu-ls       # openTofu language server
          # tfmigrate     # terraform/opentofu state migration tool for GitOps
          # tenv          # openTofu, Terraform, Terragrunt and Atmos version manager written in Go
          # terragrunt
          # tgswitch      # cli tool to switch between different versions of terragrunt
          # atmos         # universal Tool for DevOps and Cloud Automation (works with terraform, helm, helmfile, etc)
        ];

        sessionVariables.BAO_CONFIG_PATH = "${config._.dot_config}/openbao/config.hcl";

        shellAliases = {
          tf    = "tofu";
          vault = "bao";
        };
      };
    };
  };
}
