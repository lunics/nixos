{ inputs, ... }:{
  imports = [
    inputs.ags.homeManagerModules.default
    inputs.stylix.homeModules.stylix
    # inputs.nur.hmModules.nur
    ./nix_programs.nix
    ./home.nix
    ./packages
    ./xdg
    ./shell
    ./ssh_client.nix
    ./git.nix
    # ./editor.nix
    ./desktop
    ./font.nix
    ./gaming
    ./terminal
    ./file_explorer
    ./multiplexer
    ./browser
    ./gpg.nix
    ./pass_manager
    ./services
    ./k3s
    ./task_manager
    ./music
    ./stylix.nix
  ];
}
