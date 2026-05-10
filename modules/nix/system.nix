{
  flake.aspects.nix-nixos.nixos = { config, pkgs, ... }:{
    system = {
      switch.enable = true;
      activatable   = true;           # to add the activation script to the system profile
      stateVersion  = config.system.nixos.release;    # Not respected by the unstable branch
      name = if config.networking.hostName == "" then 
          "unnamed"
        else 
          config.networking.hostName;
      includeBuildDependencies     = false;
      forbiddenDependenciesRegexes = [];    # POSIX Extended Regular Expressions that match store paths that should not appear in the system closure
      extraDependencies            = [];    # paths that should be included in the system closure but generally not visible to users
      copySystemConfiguration      = false; # copies the NixOS configuration file and symlinks it from the resulting system, cannot be used when the system is configured by a flake
      configurationRevision        = null;  # git revision of the top-level flake from which this configuration was built
      services                     = {};    # collection of NixOS modular services that are configured as systemd services
      preSwitchChecks              = {};    # shell script fragments that are executed before the switch to a new generation
      activationScripts            = {};
      userActivationScripts        = {};    # shell script fragments that are executed by a systemd user service when running nixos-rebuild
      build                        = {};
      checks                       = [];    # pkgs added as dependencies of the system's build

      # build = {
      #   images      # different target images generated for this NixOS configuration
      #   toplevel
      #   separateActivationScript
      # };

      etc.overlay = {
        enable  = false;  # mount /etc as an overlayfs instead of generating it via a perl script
        mutable = true;   # mount /etc mutably (i.e. read-write) or immutably (i.e. read-only)
      };

      # image = {
      #   version       # IMAGE_VERSION field in os-release
      #   id            # IMAGE_ID field in os-release
      # };

      nixos-init = {
        enable = false;             # enable nixos-init, a system for bashless initialization
        package = pkgs.nixos-init;
      };

      nssDatabases = {
        group    = [];
        hosts    = [];
        passwd   = [];
        services = [];
        shadow   = [];
        sudoers  = [];
      };

      tools = {                      # toggle cli scripts
        nixos-build-vms.enable       = true;
        nixos-enter.enable           = true;
        nixos-generate-config.enable = true;
        nixos-install.enable         = true;
        nixos-option.enable          = true;
        nixos-rebuild.enable         = true;
        nixos-version.enable         = true;
      };

      # nixos = {     # already defined by NixOS itself
      #   codeName = "Xantusia";
      #   # release = "25.11";    # KO the option is read-only, but it's set multiple times: nixos/modules/misc/version.nix': "25.11"
      #   tags = [];        # strings to prefix to the default system.nixos.label
      #   # label = "";
      #   variant_id = null;    # lower-case string identifying a specific variant or edition of the operating system
      #   variantName = null;   # string identifying a specific variant or edition of the operating system suitable for presentation to the user
      # };
    };
  };
}
