{
  flake.aspects.task_manager.homeManager = { config, lib, ... }:{ 
    home.file = lib.mkIf (config._.current-taskw-dest != null) {
      ".config/taskwarrior/hooks/on-modify_active_task.py" = {
        executable = true;
        text = ''
          #!/usr/bin/env python3

          # Writes "project - description" to one file per project, so concurrent active tasks keep their own

          import json
          import os
          import re
          import sys

          DEST = os.path.expanduser("${config._.current-taskw-dest}")

          def dest_of(task):
            slug = re.sub(r"[^A-Za-z0-9._-]+", "-", task.get("project", "")).strip("-.")
            if not slug:
              return DEST

            stem, ext = os.path.splitext(DEST)
            return f"{stem}-{slug}{ext}"

          def main(old, new):
            old_dest = dest_of(old) if "start" in old else None
            new_dest = dest_of(new) if "start" in new and "end" not in new else None

            if old_dest and old_dest != new_dest:    # stopped, done, or moved to another project
              try:
                os.remove(old_dest)
              except FileNotFoundError:
                pass

            if new_dest:
              project = new.get("project", "")
              description = new.get("description", "")
              line = f"{project} - {description}" if project else description

              with open(new_dest, "w") as f:
                f.write(line + "\n")

          if __name__ == "__main__":
            old = json.loads(sys.stdin.readline())
            new = json.loads(sys.stdin.readline())
            print(json.dumps(new))
            main(old, new)
        '';
      };
    };
  };
}
