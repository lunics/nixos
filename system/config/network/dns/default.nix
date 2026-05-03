{
  imports = [
    ./etc_hosts.nix
    ./systemd-resolved.nix
    ./bind9
    # ./nsd
    # ./technitium-dns-server.nix   KO failed build, 1,6 GB derivation
  ];
}
