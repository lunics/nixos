{ config, lib, pkgs, ... }:{ 
  config = lib.mkIf config._.terraform {
    home = {
      packages = with pkgs; [
        opentofu
        # tofu-ls       # openTofu language server
        # tfmigrate     # terraform/opentofu state migration tool for GitOps
        # tenv          # openTofu, Terraform, Terragrunt and Atmos version manager written in Go
        # terragrunt
        # tgswitch      # cli tool to switch between different versions of terragrunt
        # atmos         # universal Tool for DevOps and Cloud Automation (works with terraform, helm, helmfile, etc)
      ];

      shellAliases.tf = "tofu";
    };
  };
}

