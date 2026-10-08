{
  flake.aspects = { aspects, ... }:{
    vagrant = {
      includes = with aspects; [
        libvirtd
      ];
      nixos = { pkgs, ... }:{
        environment = {
          systemPackages = with pkgs; [
            vagrant     # already include the vagrant-libvirt plugin
          ];

          variables.VAGRANT_DEFAULT_PROVIDER = "libvirt";
        };
      };
    };
  };
}
