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
    ./file_explorer.nix
    ./multiplexer.nix
    ./browser
    ./gpg.nix
    ./pass_manager
    ./services.nix
    ./k3s.nix
  ];

  home = {
    username      = "lunics";
    homeDirectory = "/home/lunics";
    stateVersion  = "24.05"; };
}
