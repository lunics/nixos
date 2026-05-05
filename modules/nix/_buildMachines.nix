{
  flake.modules.nixos.nix = {
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
