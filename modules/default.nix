{ inputs, ... }:{
  imports = [
    # inputs.ags.homeManagerModules.default
    # inputs.nur.hmModules.nur
    ../options
    ./nix
    ./home.nix
    ./packages
    ./xdg
    ./shell
    ./ssh_client.nix
    ./git
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
    ./kube
    ./task_manager
    ./music
    ./media
    ./editor
    ./stylix.nix
    # "./client mail"
    # ./ai
    ./torrent
    ./messaging
  ];
}
