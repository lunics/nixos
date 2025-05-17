{ inputs, ... }:{

  programs.home-manager.enable = true;

  imports = [
    inputs.ags.homeManagerModules.default
    # inputs.nur.hmModules.nur
    ./packages
    ./shell
    ./ssh_client.nix
    ./git
    ./desktop
    ./gaming
    ./terminal
    ./file_explorer
    ./multiplexer
    ./browser
    ./gpg.nix
    ./pass_manager
    ./services
    ./k3s.nix
    ./task_manager
    ./music
  ];

  home = {
    username      = "lunics";
    homeDirectory = "/home/lunics";
    stateVersion  = "24.05"; };
}
