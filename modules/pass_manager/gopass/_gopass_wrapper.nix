{ pkgs, ... }:{
  nixpkgs.overlays = [
    (self: super: {
      gopass_wrapper = super.writeShellApplication {
        name = "gopass_wrapper";
        text = ''
          export PATH="$PATH:$HOME/.nix-profile/bin" # required for Nix
          # export GPG_TTY="$(tty)"
          
          # uncomment to debug gopass-jsonapi
          export GOPASS_DEBUG_LOG=/tmp/gopass-jsonapi.log
          
          # if [ -f ~/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
          # 	source ~/.gpg-agent-info
          # 	export GPG_AGENT_INFO
          # else
          # 	eval $(gpg-agent --daemon)
          # fi
          
          "$HOME"/.nix-profile/bin/gopass-jsonapi listen
          
          exit $?
        '';
      };
    })
  ];
}
