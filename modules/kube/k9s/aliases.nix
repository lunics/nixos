# https://k9scli.io/topics/aliases/
{ config, lib, ... }:{
  config = lib.mkIf config._.kube {
    xdg.configFile."k9s/aliases.yaml".text = ''
      aliases:
        dp:  deployments
        dep: apps/v1/deployments    # alias for Deployments
        sec: v1/secrets
        jo:  jobs
        cr:  clusterroles
        crb: clusterrolebindings
        ro:  roles
        rb:  rolebindings
        np:  networkpolicies
        pp:  v1/pods                # alias for Pod
        # fred: acme.io/v1alpha1/fredericks    # alias for CRD Frederick
        # pos: pod kube-system app=fred,blee=duh    # listing all pod in kube-system matching labels app=fred and blee=duh
    '';
  };
}
