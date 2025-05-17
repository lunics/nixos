{ inputs, ... }:{

  programs.home-manager.enable = true;

  imports = [
    inputs.ags.homeManagerModules.default
    # inputs.nur.hmModules.nur
    ./packages
    ./shell
    ./ssh_client.nix
    ./git.nix
    ./desktop
    ./gaming
    ./terminal.nix
    ./file_explorer
    ./multiplexer.nix
    ./browser
    ./gpg.nix
    ./pass_manager
    ./services
    ./k3s.nix
    ./task_manager.nix
  ];

  home = {
    username      = "lunics";
    homeDirectory = "/home/lunics";
    stateVersion  = "24.05"; };
}
