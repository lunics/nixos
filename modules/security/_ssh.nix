# todo: https://mynixos.com/nixpkgs/options/programs.ssh
# regroup in 1 dir with services/ssh.nix ?
{
  flake.aspects.ssh.nixos = { pkgs, ... }:{
    programs.ssh = {
      # agentPKCS11Whitelist  = "";           # pattern-list of acceptable paths for PKCS#11 shared libraries
      # agentTimeout          = "1h";         # how long to keep private keys in memory, null = forever
      # askPassword           = "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";
      # ciphers               = [];           # ciphers allowed and their order of preference
      # hostKeyAlgorithms     = [];           # host key algorithms the client wants to use in order of preference
      # kexAlgorithms         = [];           # available KEX (Key Exchange) algorithms
      # enableAskPassword     = true;         # default = config.services.xserver.enable
      # extraConfig           = "";           # text prepended to .ssh/config
      # forwardX11            = false;
      # systemd-ssh-proxy.enable = true;
      # knownHosts = {
      #   myhost = {
      #     extraHostNames = [ "myhost.mydomain.com" "10.10.1.4" ];
      #     publicKeyFile  = ./pubkeys/myhost_ssh_host_dsa_key.pub;
      #   };
      # };
    };
  };
}
