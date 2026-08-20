#!/usr/bin/env python3

# Writes "project - description" to ~/output whenever a task is started.

import json
import os
import sys

OUTPUT = os.path.expanduser("~/output")


def main(old, new):
    if "start" in new and "start" not in old:
        project = new.get("project", "")
        description = new.get("description", "")
        line = f"{project} - {description}" if project else description

        with open(OUTPUT, "w") as f:
            f.write(line + "\n")


if __name__ == "__main__":
    old = json.loads(sys.stdin.readline())
    new = json.loads(sys.stdin.readline())
    print(json.dumps(new))
    main(old, new)
