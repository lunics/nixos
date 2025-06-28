{
  nix.sshServe = {      # nix store as a remote store via SSH
    enable   = false;
    keys     = [];      # ssh public keys allowed to access the binary cache
    protocol = "ssh";   # ssh, ssh-ng
    trusted  = false;   # whether to add nix-ssh to the nix.settings.trusted-users
    write    = false;   # whether to enable writing to the Nix store as a remote store via SSH
  };
}
