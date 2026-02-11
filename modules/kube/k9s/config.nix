{ config, lib, ... }:{
  config = lib.mkIf config._.kube {
    xdg.configFile."k9s/config.yaml".text = ''
      k9s:
        refreshRate:         2
        maxConnRetry:        5
        defaultView:         ""
        readOnly:            false
        noExitOnCtrlC:       false
        skipLatestRevCheck:  false
        screenDumpDir:       /tmp/k9s-screens-lunics
        currentCluster:      default
        liveViewAutoRefresh: false

        ui:
          skin:        transparent
          enableMouse: true
          headless:    false
          logoless:    false
          crumbsless:  false
          noIcons:     false
          reactive:    false       # reactive UI for watching on disk artifacts changes and update the UI live

        logger:
          tail:           100
          buffer:         5000
          sinceSeconds:   300
          fullScreenLogs: false
          textWrap:       false
          showTime:       false

        clusters:
          default:
            namespace:
              active:        all
              lockFavorites: false
              favorites:
                - all
                - default
            view:
              active: pods
            featureGates:
              nodeShell: false
            shellPod:
              image:   busybox:1.35.0
              command: []
              args:    []
              namespace: default
              limits:
                cpu:    100m
                memory: 100Mi
              labels: {}
            portForwardAddress: localhost

        thresholds:
          cpu:
            critical: 90
            warn:     70
          memory:
            critical: 90
            warn:     70
    '';
  };
}
