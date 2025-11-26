{ config, lib, pkgs, ... }:{ 
  config = lib.mkIf config._.ansible {
    home = {
      packages = with pkgs; [
        ansible
        sshpass    # required by ansible for remote connections
      ];

      shellAliases.a = "ansible-playbook";

      sessionVariables = {
        ANSIBLE         = "$HOMELAB/ansible";
        ANSIBLE_CONFIG  = "$ANSIBLE/ansible.cfg";
        GALAXY          = "$ANSIBLE/galaxy";
      };
    };
  };
}
