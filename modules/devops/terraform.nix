{
  flake.aspects.devops.homeManager = { config, lib, pkgs, ... }:{ 
    config = lib.mkIf config._.terraform {
      # ~/.vault-token stays ephemeral, bao login replaces it by rename and a bind mounted file refuses that
      _.persistent-home.dirs = [ ".terraform.d" ];    # tofu login credentials

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

        shellAliases = {
          tf    = "tofu";
          vault = "bao";
        };
      };
    };
  };
}
