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
    ./kube
    ./task_manager
    ./music
    ./media         # KO if no usb_copy/share present
    ./stylix.nix
    ./pomodoro
    # "./client mail"
    ./ai
  ];
}
