{
  imports = [
    ./etc_hosts.nix
    ./systemd-resolved.nix
    ./bind.nix
    ./thinkpad-t14.db.nix
    # ./technitium-dns-server.nix   KO failed build, 1,6 GB derivation
  ];
}
