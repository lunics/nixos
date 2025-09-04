#!/usr/bin/env bash

source ~/.nix-profile/etc/profile.d/hm-session-vars.sh

if task +ACTIVE >& /dev/null; then
  project=$(task +ACTIVE _project)
  time=$(task +ACTIVE rc.verbose=nothing | awk '{print $NF}')
  echo '{"message":"'$project' '$time'"}'
else
  echo '{"message":""}'
fi
