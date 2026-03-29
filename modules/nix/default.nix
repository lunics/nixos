{
  imports = [
    ./main.nix
    # ./buildMachines.nix
    ./nixpkgs.nix
    ./gc.nix
    ./optimise.nix
    # ./registry.nix    ## TODO
    ./settings.nix
    ./sshServe.nix
    ./impermanence.nix
  ];
}
