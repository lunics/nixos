{
  flake.aspects.k3s.nixos = { config, lib, pkgs, ... }: with lib; let
    # clan returns /no-such-path for a generator declared but not yet imported, sops then takes over
    clan-key = config.clan.core.vars.generators.argo-cd-ssh-kube-repo.files.id_ed25519.path or null;
    sops-key = config.sops.secrets."argo-cd/ssh-kube-repo".path or null;
    ssh-key  = if clan-key != null && clan-key != "/no-such-path" then clan-key else sops-key;
  in {
    config = mkIf (config._.k3s.enable) (mkMerge [
      {
        assertions = [{
          assertion = ssh-key != null;
          message   = "argo-cd: missing secrets ssh private key";
        }];
      }

      (mkIf (ssh-key != null) {
        systemd.services.argo-cd-git-repo = {
          description = "Provision Argo CD git repository";
          wantedBy    = [ "multi-user.target" ];
          after       = [ "argo-cd-secrets.service" ];
          requires    = [ "argo-cd-secrets.service" ];
          path        = with pkgs; [ coreutils ];   # required by base64
          serviceConfig = {
            Type            = "oneshot";
            RemainAfterExit = true;
          };
          script = ''
            ${config._.k3s.kubectl} apply -f - <<EOF
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
              sshPrivateKey: $(printf '%s' "$(cat ${ssh-key})" | base64 -w0)
            EOF
          '';
        };
      })
    ]);
  };
}
