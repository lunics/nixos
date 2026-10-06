# TODO: build a nixos qcow2 image and use it as backing_vol in nixvirt-vm-template.nix, no iso install needed
{
  # 1. guest config, a regular nixosConfiguration (hosts/penguin) including the qemu-guest aspect
  #    nixos-generators is upstreamed, nixpkgs exposes the image variants under system.build.images
  #
  # flake.aspects.penguin.nixos = { modulesPath, ... }:{
  #   imports = [ "${modulesPath}/profiles/qemu-guest.nix" ];
  #   virtualisation.diskSize = 20 * 1024;                     # MiB, used by image/disk-image.nix
  #   image.baseName          = "penguin";
  #   fileSystems."/".device  = "/dev/disk/by-label/nixos";
  #   boot.loader.grub.device = "/dev/vda";                    # qemu variant is bios, qemu-efi needs systemd-boot
  # };
  #
  # cli build: nixos-rebuild build-image --image-variant qemu --flake .#penguin

  # 2. alternative without image.modules: make-disk-image directly
  #
  # image = import "${inputs.nixpkgs}/nixos/lib/make-disk-image.nix" {
  #   inherit lib pkgs;
  #   config             = inputs.self.nixosConfigurations.penguin.config;
  #   format             = "qcow2";
  #   diskSize           = "auto";
  #   additionalSpace    = "2G";
  #   partitionTableType = "legacy";                           # legacy, efi, hybrid, none
  #   copyChannel        = false;
  # };

  # 3. host side, in nixvirt-vm-template.nix
  #
  # penguin  = inputs.self.nixosConfigurations.penguin.config;
  # base-img = "${penguin.system.build.images.qemu}/${penguin.image.filePath}";
  #
  # backing_vol = base-img;                                    # read-only in the store, kept alive by the domain xml
  # install_vol = null;
  # volumes = [{                                               # the overlay must carry the backing file in its qcow2 header
  #   definition = nixvirt.volume.writeXML {
  #     name         = "${vm-name}.qcow2";
  #     capacity     = { count = 40; unit = "GiB"; };
  #     target       = { format = { type = "qcow2"; }; };
  #     backingStore = { path = base-img; format = { type = "qcow2"; }; };
  #   };
  # }];
  #
  # warning: a guest rebuild gives a new store path, the existing overlay still points to the old one
  #          the old image is then garbage collected => delete and recreate the overlay, or nixos-rebuild inside the guest
}
