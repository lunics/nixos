{ inputs, pkgs, ... }:{
  imports = [ inputs.k0s.nixosModules.default ];

  environment.systemPackages = with pkgs; [
    k0sctl      # bootstrapping and management tool for k0s clusters
  ];

  services.k0s = {
    enable      = false;
    packages    = inputs.k0s.packages.${pkgs.stdenv.hostPlatform.system}.k0s;
    role        = "single";    # controller, controller+worker, worker, single
    dataDir     = "/var/lib/k0s";
    tokenFile   = "/etc/k0s/k0stoken";
    clusterName = "k0s";
    spec        = {};
    configText  = "";      # the configuration file in yaml format
    extraArgs   = "";       # extra arguments to pass to systemd ExecStart
  };
}
