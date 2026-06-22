{
  flake.aspects.k3s.nixos = { config, options, lib, pkgs, ... }: with lib; {
    config = mkIf (config._.k3s.enable) {
      assertions = [{
        assertion = config.sops.secrets ? "argo-cd/ssh-kube-repo";
        message   = "argo-cd: missing secrets ssh private key";
      }];

      systemd.services.argo-cd-git-repo = {
        description = "Provision Argo CD git repository";
        wantedBy    = [ "multi-user.target" ];
        after       = [ "argo-cd-secrets.service" ];
        requires    = [ "argo-cd-secrets.service" ];
        serviceConfig = {
          Type            = "oneshot";
          RemainAfterExit = true;
        };
        script = ''
          ${pkgs.kubectl}/bin/kubectl apply -f - <<EOF
          apiVersion: v1
          kind: Secret
          metadata:
            name: argocd-repo
            namespace: argo-cd
            labels:
              argocd.argoproj.io/secret-type: repository
          type: Opaque
          stringData:
            name:      argo-cd
            project:   default
            type:      git
            url:       git@${config._.argo-cd-repo-url}
            insecure:  "true"
            enableLfs: "false"
          data:
            # printf '%s' to remove the \n at the end of the secret file
            sshPrivateKey: $(printf '%s' "$(cat ${config.sops.secrets."argo-cd/ssh-kube-repo".path})" | base64 -w0)
          EOF
        '';
      };
    };
  };
}
