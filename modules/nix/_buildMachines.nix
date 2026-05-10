{
  flake.aspects.nix-nixos.nixos = {
    nix.buildMachines."NAME" = {
      hostName
      mandatoryFeatures
      maxJobs
      protocol
      publicHostKey
      speedFactor
      sshKey
      sshUser
      supportedFeatures
      system
      systems
    };
  };
}
