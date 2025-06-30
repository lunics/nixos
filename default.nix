{ inputs, ... }:{
  imports = [
    inputs.ags.homeManagerModules.default
    # inputs.nur.hmModules.nur
    ./nix_programs.nix
    ./home.nix
    ./packages
    # ./xdg.nix
    ./shell
    ./ssh_client.nix
    ./git.nix
    # ./editor.nix
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
}
