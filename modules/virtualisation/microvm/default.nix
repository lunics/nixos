{ inputs, ... }:{
  imports = [
    inputs.microvm.nixosModules.host
    ./microvm.nix
    ./firewall.nix
    ./nat.nix
    ./systemd.nix
  ];
}
