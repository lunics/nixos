{
  flake.aspects = { aspects, ... }:{
    kvm = {
      includes = with aspects; [
        facter
      ];
      nixos = { config, ... }:{
        assertions = [{
          # kvm-intel / kvm-amd are loaded by nixpkgs hardware/facter/virtualisation.nix from the cpu vmx / svm flags
          assertion = config.hardware.facter.enable;
          message   = "set _.facter-report or the clan facter.json to help facter to load kvm-intel or kvm-amd";
        }];
      };
    };
  };
}
