{
  xdg.configFile."k9s/hotkeys.yaml".text = ''
    # Built‑in NAVIGATION actions cannot be override
    hotKeys:
      quit_app:
        shortCut:    q
        description: Quit
        command:     quit

      # q:
      #   shortCut: q
      #   description: Go back
      #   command: Back

      delete:
        shortCut:    Delete
        description: Delete resource
        command:     delete

      h:
        shortCut:    h
        description: Back
        command:     back
        override:    true     # override the default shortcut related action
        # keepHistory: true     # return to the previous view

      # shift-h:
      #   shortCut:    Shift-H
      #   description: Left
      #   command:     left

      # shift-l:
      #   shortCut:    Shift-L
      #   description: Right
      #   command:     right

      shift-0:
        shortCut:    Shift-0
        description: Viewing pods
        command:     pods

      shift-1:
        shortcut:    Shift-1
        description: View deployments
        command:     dp

      shift-2:
        shortcut:    Shift-2
        description: View services
        command:     services

      shift-5:
        shortCut:    Shift-5
        description: View workloads
        command:     wk

      # shift-3:
      #   shortCut:    Shift-3
      #   description: Viewing git repositories
      #   command:     gitrepositories

      # shift-0:
      #   shortCut:    Shift-0
      #   description: Viewing pods
      #   command:     pods
    
      # # Hitting Shift-1 navigates to your deployments
      # shift-1:
      #   shortCut:    Shift-1
      #   description: View deployments
      #   command:     dp
  '';
}
