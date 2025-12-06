{ config, lib, pkgs, ... }:let
  ansible_path = "${config._.share}/../ansible"; 
in {
  config = lib.mkIf config._.ansible {
    home = {
      packages = with pkgs; [
        ansible
        sshpass    # required by ansible for remote connections
      ];

      file.".config/ansible/ansible.cfg".text = ''
        [defaults]
        roles_path          = ${ansible_path}/roles
        inventory           = ${ansible_path}/inventory/hosts.yml
        library             = ${ansible_path}/plugins/library
        vault_password_file = ${ansible_path}/plugins/vault_pass.sh
        ansible_config      = /var/log/ansible/ansible-playbook_$(date +"%Y-%m-%d_%Hh%M").log
      '';

      shellAliases.a = "ansible-playbook";

      sessionVariables = {
        ANSIBLE         = "${ansible_path}";
        ANSIBLE_CONFIG  = "${config._.dot_config}/ansible.cfg";
        GALAXY          = "${ansible_path}/galaxy";
      };
    };
  };
}
