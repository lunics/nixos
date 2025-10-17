{ inputs, ... }:{
  imports = [
    # inputs.ags.homeManagerModules.default
    # inputs.nur.hmModules.nur
    ../options
    ./nix_programs.nix
    ./devbox
    ./home.nix
    ./packages
    ./xdg
    ./shell
    ./ssh_client.nix
    ./git
    ./neovim
    ./editor.nix
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
    ./media
    ./stylix.nix
  ];
}
